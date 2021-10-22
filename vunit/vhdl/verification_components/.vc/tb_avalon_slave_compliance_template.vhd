-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2021, Lars Asplund lars.anders.asplund@gmail.com

library ieee;
library osvvm;
library vunit_lib;
context vunit_lib.com_context;
context vunit_lib.vunit_context;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use osvvm.randompkg.all;
use vunit_lib.avalon_pkg.all;
use vunit_lib.memory_pkg.all;
use vunit_lib.sync_pkg.all;
use vunit_lib.vc_pkg.all;

entity tb_avalon_slave_compliance is
  generic(
    runner_cfg : string);
end entity;

architecture tb of tb_avalon_slave_compliance is

  constant avalon_slave : avalon_slave_t := new_avalon_slave(
    memory => new_memory
  );

  signal clk : std_logic;
  signal address : std_logic_vector(31 downto 0);
  signal byteenable : std_logic_vector(3 downto 0);
  signal burstcount : std_logic_vector(7 downto 0);
  signal waitrequest : std_logic;
  signal write : std_logic;
  signal writedata : std_logic_vector(31 downto 0);
  signal read : std_logic;
  signal readdata : std_logic_vector(31 downto 0);
  signal readdatavalid : std_logic;

begin
  test_runner : process
  begin
    test_runner_setup(runner, runner_cfg);
    test_runner_cleanup(runner);
  end process test_runner;

  vc_inst: entity vunit_lib.avalon_slave
    generic map(avalon_slave)
    port map(
      clk => clk,
      address => address,
      byteenable => byteenable,
      burstcount => burstcount,
      waitrequest => waitrequest,
      write => write,
      writedata => writedata,
      read => read,
      readdata => readdata,
      readdatavalid => readdatavalid
    );

end architecture;