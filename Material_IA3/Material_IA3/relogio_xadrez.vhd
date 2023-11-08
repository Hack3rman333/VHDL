--------------------------------------------------------------------------------
-- RELOGIO DE XADREZ
-- Author - Fernando Moraes - 25/out/2023
-- Revision - Iaçanã Ianiski Weber - 30/out/2023
--------------------------------------------------------------------------------
library IEEE;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;

entity relogio_xadrez is
    port( 
            init_time: in std_logic_vector(7 downto 0);
            j1 : in std_logic;
            j2 : in std_logic;
            load : in std_logic;
            clock : in std_logic;
            reset : in std_logic;

            contj2 : out std_logic_vector(15 downto 0);
            contj1 : out std_logic_vector(15 downto 0);
            winj1 : out std_logic;
            winj2 : out std_logic;
    );
end relogio_xadrez;

architecture relogio_xadrez of relogio_xadrez is
    -- DECLARACAO DOS ESTADOS
    type states is (vencedor1, vencedor2, iniciar, carregar, jj1, jj2

    
    );
    signal EA, PE : states;
        signal en1 : std_logic
        signal en2 : std_logic

    
begin

    -- INSTANCIACAO DOS CONTADORES
    contador1 : entity work.temporizador port map (
        en => en1,
        load => load,
        init_time => init_time,
        clock => clock,
        reset => reset,
        cont => contj1
        
     );
    contador2 : entity work.temporizador port map (
        init_time => init_time,
        load => load,
        en => en2,
        clock => clock,
        reset => reset,
        cont => contj2
    );
    -- PROCESSO DE TROCA DE ESTADOS
    process (clock, reset)
    begin
        -- COMPLETAR COM O PROCESSO DE TROCA DE ESTADO
        if reset = '1'
            then EA <= iniciar;
        else 
            if load = '1'
                then EA <= carregar;
        else
            EA <= PE;
        end if;
    end if;
        
    end process;

    -- PROCESSO PARA DEFINIR O PROXIMO ESTADO
    process ( ) --<<< Nao esqueca de adicionar os sinais da lista de sensitividade
    begin
        case EA is
           when jj1 => 
            if j1 = '1'
                then PE <= jj2;
            else
                PE <= jj1;
                if contj1 = x"0"
                    then PE <= vencedor2;
                end if;
            end if;

            when jj2 =>
            if j2 = '1'
                then PE <= jj1;
            else
                PE <= jj2;
                if contj2 = x"0"
                    then PE <= vencedor1;
                end if;
            end if;
            
            when iniciar =>
                if load = '1' 
                then PE <= carregar; 
                    else PE <= iniciar;
                end if;

            when carregar =>
                if j1 = '1' 
                then PE <= jj1;
                else PE <= jj2;

            
           

        end case;
    end process;

    
    -- ATRIBUICAO COMBINACIONAL DOS SINAIS INTERNOS E SAIDAS - Dica: faca uma maquina de Moore, desta forma os sinais dependem apenas do estado atual!!
    

end relogio_xadrez;


