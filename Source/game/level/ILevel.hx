package game.level;

import game.entity.player.Player;
import game.Game;

interface ILevel
{
   function init(player:Player, game:Game):Void;
   function update():Void;
   function exit():Void;
}