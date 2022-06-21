import 'Coracle/coracle'
import 'Coracle/Particles/hyperspace'

class('HyperspaceScene').extends()

local synthFilterResonance = 0.1
local synthFilterFrequency = 400

local onHyperspaceSceneDismiss = nil

local onHyperspaceDismiss = function()
	print("Hyperspace finished... pop screen")
	onHyperspaceSceneDismiss()
end

function HyperspaceScene:init(message, _onHyperspaceSceneDismiss)
	 HyperspaceScene.super.init(self)
	 onHyperspaceSceneDismiss = _onHyperspaceSceneDismiss
	 
	 self.hyperspace = Hyperspace(85, onHyperspaceDismiss)
	 self.message = message
	 
	 self.synth = sound.synth.new(playdate.sound.kWaveNoise)
	 local filter = sound.twopolefilter.new("lowpass") -- XXX - snd.kFilterLowPass should work
	 filter:setResonance(0.1)
	 filter:setFrequency(400)
	 sound.addEffect(filter)
	 self.synth:setVolume(1.0)
	 if(playAudio)then
	 	self.synth:playNote(330)
	 end
end

function HyperspaceScene:draw()
	backgroundDark()
	self.hyperspace:draw()
	
	text(self.message, 10, 220)
	
	if(SKIP_HYPERSPACE)then
		self:clear()
		onHyperspaceSceneDismiss()
	end
end

function HyperspaceScene:clear()
	print("HyperspaceScene clear()")
	self.synth:stop()
end