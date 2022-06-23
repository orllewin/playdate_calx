import 'Coracle/coracle'
import 'Coracle/Particles/hyperspace'

class('HyperspaceScene').extends()

local synthFilterResonance = 0.1
local synthFilterFrequency = 400

local onHyperspaceSceneDismiss = nil

local onHyperspaceDismiss = function()
	print("Hyperspace finished... pop screen")
	if(onHyperspaceSceneDismiss ~= null)then
		onHyperspaceSceneDismiss()
	else
		--todo - start level 1
		activeScene:clear()
		activeScene = Level1Scene()
	end
	
end

function HyperspaceScene:init(message, _onHyperspaceSceneDismiss)
	 HyperspaceScene.super.init(self)
	 
	 if(_onHyperspaceSceneDismiss ~= nil)then
	 	onHyperspaceSceneDismiss = _onHyperspaceSceneDismiss
 		end
	 
	 self.hyperspace = Hyperspace(85, onHyperspaceDismiss)
	 self.message = message
	 
	 self.synth = sound.synth.new(playdate.sound.kWaveNoise)
	 self.filter = sound.twopolefilter.new("lowpass") -- XXX - snd.kFilterLowPass should work
	 self.filter:setResonance(0.1)
	 self.filter:setFrequency(400)
	 sound.addEffect(self.filter)
	 self.synth:setVolume(1.0)
	 if(PLAY_AUDIO)then
	 	self.synth:playNote(330)
	 end
end

function HyperspaceScene:draw()
	background(black)
	self.hyperspace:draw()
	
	text(self.message, 10, 220)
	
	if(SKIP_HYPERSPACE)then
		self:clear()
		onHyperspaceDismiss()
	end
end

function HyperspaceScene:clear()
	print("HyperspaceScene clear()")
	self.synth:stop()
	sound.removeEffect(self.filter)
end