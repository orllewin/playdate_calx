class('Audio').extends()

function Audio:init()
	 Audio.super.init(self)
	 self.filePlayer = playdate.sound.fileplayer.new()
end

function Audio:playIntro()
	self.filePlayer:load("audio/rolemusic_pokimonkey")
	self.filePlayer:play(0)
end

function Audio:playLevel1()
	self.filePlayer:load("audio/rolemusic_itsumo_no_y_ni")
	self.filePlayer:play(0)
end

function Audio:clear()
	self.filePlayer:stop()
end