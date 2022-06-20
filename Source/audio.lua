class('Audio').extends()

function Audio:init()
	 Audio.super.init(self)
	 self.filePlayer = playdate.sound.fileplayer.new()
end

function Audio:playIntro()
	self.filePlayer:load("audio/rolemusic_pokimonkey")
	self.filePlayer:play(0)
end

function Audio:clear()
	self.filePlayer:stop()
end