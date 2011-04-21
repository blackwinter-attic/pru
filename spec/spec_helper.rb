LIB_DIR = File.expand_path('../../lib', __FILE__)
PRU_CMD = "#{File.join(File.dirname(LIB_DIR), 'bin', 'pru')} -I#{LIB_DIR}"

$LOAD_PATH.unshift LIB_DIR
require 'pru'
