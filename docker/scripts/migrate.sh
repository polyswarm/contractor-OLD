#!/usr/bin/env ruby

require "colorize"

ROOTDIR     = "/usr/src/app"
TRUFFLE_DIR = "#{ROOTDIR}/truffle"

#
# XXX these update .cfg files should be
#     properly located if required by
#     polyswarm/polyswarmd container.
#     since polyswarm/queenb, this container
#     mounts to specific volume and referred
#     by the caller, polyswarmd.
#
DOCKER_CONFIG = "#{TRUFFLE_DIR}/polyswarmd.docker.cfg"
CONFIG        = "#{TRUFFLE_DIR}/polyswarmd.cfg"

def say(txt)
  puts "[#{txt}] ..."
end

def say_and_do(txt)
  puts "[#{txt}] ..."
  system txt
end

def dev_null(cmd)
  say "#{cmd} >/dev/null &"
  system "#{cmd} >/dev/null &"
end

def paint(response)
   puts response.split("\n").map(&:blue).join("\n").blue
end

def migrate
  say "#{TRUFFLE_DIR}/migrations"
  system "cp -r /backup/truffle #{ROOTDIR}"

  puts `ls -lt -r #{TRUFFLE_DIR}/migrations`
  puts `echo backup; ls -lt -r /backup/truffle/migrations`
  puts `cat #{TRUFFLE_DIR}/truffle-config.js`.split("\n").map(&:blue).join("\n")

  #
  # DO I HAVE TO UNLOCK ACOUNT?
  #
  say "truffle migrate --reset (this will take a while ...)"
  response = `cd #{TRUFFLE_DIR}; truffle migrate --reset`
  paint(response)
  return response.to_s
end

def parse_response_into_token(response)
  paint "[RESPONSE]: #{response}".yellow

  nectar_token    = /NectarToken\:.+/.match(response).to_s.gsub("NectarToken: ", "")
  bounty_registry = /BountyRegistry\:.+/.match(response).to_s.gsub("BountyRegistry: ", "")
  offer_registry  = /OfferRegistry\:.+/.match(response).to_s.gsub("OfferRegistry: ", "")

  if [nectar_token, bounty_registry, offer_registry].include?("")
    abort("truffle migrate failure.")
  end

  config = "NECTAR_TOKEN_ADDRESS    = '#{nectar_token}'\n" + 
           "BOUNTY_REGISTRY_ADDRESS = '#{bounty_registry}\n'" +
           "OFFER_REGISTRY_ADDRESS = '#{offer_registry}'"
 
  return config
end

#
# MIGRATE AND GENERATE THE CONFIG FILE
# 
say ">> sudo truffle migrate --reset"

migration_result = migrate()
puts migration_result.red
config = parse_response_into_token(migration_result)

puts config.blue

File.open(DOCKER_CONFIG, "w") { |f| f.puts config }
File.open(CONFIG, "w") { |f| f.puts config }

say    "truffle reset done"

say    DOCKER_CONFIG
system "cat #{DOCKER_CONFIG}"

say    CONFIG
system "cat #{CONFIG}"

say    "mint tokens ..."
system "cd /usr/src/app/truffle; ./scripts/mint_tokens.sh"
say    "mint tokens done ..."

say `find / -name genesis.json`.green
system "find / -name genesis.json"

puts "--------------------------------------------"
