-- Help! Get_line is insane!
--      - some dude in 1995[^1]
--
-- Help! Get_line is insane!
--      - me, 2022
--
-- [1]: https://groups.google.com/g/comp.lang.ada/c/t58iiAUz6cI

with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Fixed;


procedure Pt1 is
    NULLCH : constant Character := Character'Val(0);

    type Stack_data is array (0 .. 127) of Character;
    type Stack is record
        Data : Stack_data := (0 .. 127 => NULLCH);
        Top  : Integer := 0;
    end record;
    type Stack_array is array (0 .. 31) of Stack;

    procedure Push(S : in out Stack; C : Character) is
    begin
        S.Data(S.Top) := C;
        S.Top := S.Top + 1;
    end;

    function Pop(S : in out Stack) return Character is
    begin
        S.Top := S.Top - 1;
        return S.Data(S.Top);
    end;

    function Is_Empty(S : Stack) return Boolean is
    begin
        return S.Top = 0;
    end;

    function Reversed(S : in out Stack) return Stack is
        Temp : Stack;
    begin
        loop
            exit when Is_Empty(S);
            Push(Temp, Pop(S));
        end loop;
        return Temp;
    end;

    Crate : Character;
    Line : String (1 .. 81);
    Line_Index : Integer := 0;
    Line_Length : Integer;
    Stacks : Stack_array;

    Crate_Count : Integer;
    Crate_Origin : Integer;
    Crate_Destiny : Integer;

    Word_Start : Integer;
    Word_End : Integer;
begin
    balls: loop
        Get_Line(Line, Line_Length);

        for Crate_i in 0 .. Line_Length / 4 loop
            Crate := Line(2 + Crate_i * 4);
            exit balls when Crate in '0' .. '9';
            if crate /= ' ' then
                Push(Stacks(Crate_i), Crate);
            end if;
        end loop;

        Line_Index := Line_Index + 1;

        exit when End_of_file;
    end loop balls;

    for S of Stacks loop
        S := Reversed(S);
    end loop;

    loop
        <<balls2real>> Get_Line(Line, Line_Length);

        if Line_Length = 0 then
            exit when End_of_file;
            goto balls2real;
        end if;

        Word_Start := 0;
        Word_End := 0;

        loop
            Word_Start := Word_End + 1;
            Word_End := Ada.Strings.Fixed.Index(Line(Word_Start .. Line_Length), " ");
            exit when Word_End = 0;

            if Line(Word_Start .. Word_End) = "move " then
                Word_Start := Word_End + 1;
                Word_End := Ada.Strings.Fixed.Index(Line(Word_Start .. Line_Length), " ");
                Crate_Count := Integer'Value(Line(Word_Start .. Word_End));
            elsif Line(Word_Start .. Word_End) = "from " then
                Word_Start := Word_End + 1;
                Word_End := Ada.Strings.Fixed.Index(Line(Word_Start .. Line_Length), " ");
                Crate_Origin := Integer'Value(Line(Word_Start .. Word_End));
            elsif Line(Word_Start .. Word_End) = "to " then
                Crate_Destiny := Integer'Value(Line(Word_End + 1 .. Line_Length));
                exit;
            end if;
        end loop;

        for I in 1 .. Crate_Count loop
            Push(Stacks(Crate_Destiny - 1), Pop(Stacks(Crate_Origin - 1)));
        end loop;

        exit when End_of_file;
    end loop;

    for S of Stacks loop
        if not Is_Empty(S) then
            Put(S.Data(S.Top - 1));
        end if;
    end loop;
end Pt1;
