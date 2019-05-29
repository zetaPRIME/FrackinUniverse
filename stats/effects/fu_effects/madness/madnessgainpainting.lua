function init()
  self.baseValue = config.getParameter("baseValue")
  self.valBonus = config.getParameter("valBonus") - ((config.getParameter("mentalProtection") or 0) * 10)
  self.timer = 10
  
  animator.setParticleEmitterOffsetRegion("insane", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("insane", config.getParameter("emissionRate", 3))
  animator.setParticleEmitterActive("insane", true)
  activateVisualEffects()
  
  script.setUpdateDelta(3)
end

function update(dt)
  	self.timer = self.timer - dt
	if (self.timer <= 0) then
	        self.healthDamage = 3 * ((status.stat("mentalProtection") or 0)*10)
		self.timer = 30
		self.totalValue = self.baseValue + self.valBonus
		world.spawnItem("fumadnessresource",entity.position(),self.totalValue)
		animator.playSound("madness")
		activateVisualEffects()
		    status.applySelfDamageRequest({
		      damageType = "IgnoresDef",
		      damage = self.healthDamage,
		      damageSourceKind = "shadow",
		      sourceEntityId = entity.id()
		    })
  	end
end


function activateVisualEffects()
  effect.setParentDirectives("fade=765e72=0.4")
  local statusTextRegion = { 0, 1, 0, 1 }
  animator.setParticleEmitterOffsetRegion("statustext", statusTextRegion)
  animator.burstParticleEmitter("statustext")
end


function uninit()

end