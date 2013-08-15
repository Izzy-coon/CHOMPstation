/mob/living/silicon/ai/say(var/message)
	if(parent && istype(parent) && parent.stat != 2)
		parent.say(message)
		return
		//If there is a defined "parent" AI, it is actually an AI, and it is alive, anything the AI tries to say is said by the parent instead.
	..(message)

/mob/living/silicon/ai/say_understands(var/other)
	if (istype(other, /mob/living/carbon/human))
		return 1
	if (istype(other, /mob/living/silicon/robot))
		return 1
	if (istype(other, /mob/living/silicon/decoy))
		return 1
	if (istype(other, /mob/living/carbon/brain))
		return 1
	if (istype(other, /mob/living/silicon/pai))
		return 1
	return ..()

/mob/living/silicon/ai/say_quote(var/text)
	var/ending = copytext(text, length(text))

	if (ending == "?")
		return "queries, \"[text]\"";
	else if (ending == "!")
		return "declares, \"[text]\"";

	return "states, \"[text]\"";

var/announcing_vox = 0
var/const/VOX_CHANNEL = 200
var/const/VOX_VOLUME = 75

/mob/living/silicon/ai/verb/announcement_help()

	set name = "Announcement Help"
	set desc = "Display a list of vocal words to announce to the crew."
	set category = "AI Commands"

	src << "\red VOX is disabled until issues with the code can be sorted."
	return
/*	var/dat = "Here is a list of words you can type into the Announcement button to create sentences to vocally announce.<BR> \
	Do not use punctuation as you would normally, if you want a pause you can use the full stop and comma characters by separating them with spaces, like so: 'Alpha . Test , Bravo'.<BR>"

	var/index = 0
	for(var/word in vox_sounds)
		index++
		dat += "<A href='?src=\ref[src];say_word=[word]'>[capitalize(word)]</A>"
		if(index != vox_sounds.len)
			dat += " / "

	src << browse(dat, "window=announce_help;size=500x400")*/


/mob/living/silicon/ai/verb/announcement(var/message as text)

	set name = "Announcement"
	set desc = "Create a vocal announcement by typing in the available words to create a setence. More help is available in 'Announcement Help'"
	set category = "AI Commands"

	src << "\red VOX is disabled until issues with the code can be sorted."
	return
/*
	if(!message)
		return
	//if(!announcing_vox > world.time)
	//	return

	log_game("[key_name_admin(src)] made a vocal announcement with the following message: [message].")

	announcing_vox = world.time + 30

	var/list/words = stringsplit(trim(message), " ")
	var/list/incorrect_words = list()

	if(words.len > 32)
		words.len = 32
	for(var/word in words)
		word = trim(word)
		if(!word)
			continue
		if(!play_vox_word(word, src.z)) // If the word isn't speakable
			incorrect_words += word

	if(incorrect_words.len)
		src << "<span class='notice'>These words are not available on the announcement system: [english_list(incorrect_words)].</span>"
*/
/proc/play_vox_word(var/word, var/z_level)
/*
	word = lowertext(word)

	if(vox_sounds[word])

		var/sound_file = vox_sounds[word]
		var/sound/voice = sound(sound_file, wait = 1, channel = VOX_CHANNEL, volume = VOX_VOLUME)
		voice.status = SOUND_STREAM

		// Play voice for all mobs in the z level
		for(var/mob/M in player_list)
			if(M.client)
				var/turf/T = get_turf(M)
				if(T.z == z_level)
					M << voice
		return 1
	return 0*/

// List is required to compile the resources into the game when it loads.
// Dynamically loading it has bad results with sounds overtaking each other, even with the wait variable.

var/list/vox_sounds = list(/*"," = 'sound/vox/,.wav',
"." = 'sound/vox/..wav',
"a" = 'sound/vox/a.wav',
"accelerating" = 'sound/vox/accelerating.wav',
"accelerator" = 'sound/vox/accelerator.wav',
"accepted" = 'sound/vox/accepted.wav',
"access" = 'sound/vox/access.wav',
"acknowledge" = 'sound/vox/acknowledge.wav',
"acknowledged" = 'sound/vox/acknowledged.wav',
"acquired" = 'sound/vox/acquired.wav',
"acquisition" = 'sound/vox/acquisition.wav',
"across" = 'sound/vox/across.wav',
"activate" = 'sound/vox/activate.wav',
"activated" = 'sound/vox/activated.wav',
"activity" = 'sound/vox/activity.wav',
"adios" = 'sound/vox/adios.wav',
"administration" = 'sound/vox/administration.wav',
"advanced" = 'sound/vox/advanced.wav',
"after" = 'sound/vox/after.wav',
"agent" = 'sound/vox/agent.wav',
"alarm" = 'sound/vox/alarm.wav',
"alert" = 'sound/vox/alert.wav',
"alien" = 'sound/vox/alien.wav',
"aligned" = 'sound/vox/aligned.wav',
"all" = 'sound/vox/all.wav',
"alpha" = 'sound/vox/alpha.wav',
"am" = 'sound/vox/am.wav',
"amigo" = 'sound/vox/amigo.wav',
"ammunition" = 'sound/vox/ammunition.wav',
"an" = 'sound/vox/an.wav',
"and" = 'sound/vox/and.wav',
"announcement" = 'sound/vox/announcement.wav',
"anomalous" = 'sound/vox/anomalous.wav',
"antenna" = 'sound/vox/antenna.wav',
"any" = 'sound/vox/any.wav',
"apprehend" = 'sound/vox/apprehend.wav',
"approach" = 'sound/vox/approach.wav',
"are" = 'sound/vox/are.wav',
"area" = 'sound/vox/area.wav',
"arm" = 'sound/vox/arm.wav',
"armed" = 'sound/vox/armed.wav',
"armor" = 'sound/vox/armor.wav',
"armory" = 'sound/vox/armory.wav',
"arrest" = 'sound/vox/arrest.wav',
"ass" = 'sound/vox/ass.wav',
"at" = 'sound/vox/at.wav',
"atomic" = 'sound/vox/atomic.wav',
"attention" = 'sound/vox/attention.wav',
"authorize" = 'sound/vox/authorize.wav',
"authorized" = 'sound/vox/authorized.wav',
"automatic" = 'sound/vox/automatic.wav',
"away" = 'sound/vox/away.wav',
"b" = 'sound/vox/b.wav',
"back" = 'sound/vox/back.wav',
"backman" = 'sound/vox/backman.wav',
"bad" = 'sound/vox/bad.wav',
"bag" = 'sound/vox/bag.wav',
"bailey" = 'sound/vox/bailey.wav',
"barracks" = 'sound/vox/barracks.wav',
"base" = 'sound/vox/base.wav',
"bay" = 'sound/vox/bay.wav',
"be" = 'sound/vox/be.wav',
"been" = 'sound/vox/been.wav',
"before" = 'sound/vox/before.wav',
"beyond" = 'sound/vox/beyond.wav',
"biohazard" = 'sound/vox/biohazard.wav',
"biological" = 'sound/vox/biological.wav',
"birdwell" = 'sound/vox/birdwell.wav',
"bizwarn" = 'sound/vox/bizwarn.wav',
"black" = 'sound/vox/black.wav',
"blast" = 'sound/vox/blast.wav',
"blocked" = 'sound/vox/blocked.wav',
"bloop" = 'sound/vox/bloop.wav',
"blue" = 'sound/vox/blue.wav',
"bottom" = 'sound/vox/bottom.wav',
"bravo" = 'sound/vox/bravo.wav',
"breach" = 'sound/vox/breach.wav',
"breached" = 'sound/vox/breached.wav',
"break" = 'sound/vox/break.wav',
"bridge" = 'sound/vox/bridge.wav',
"bust" = 'sound/vox/bust.wav',
"but" = 'sound/vox/but.wav',
"button" = 'sound/vox/button.wav',
"buzwarn" = 'sound/vox/buzwarn.wav',
"bypass" = 'sound/vox/bypass.wav',
"c" = 'sound/vox/c.wav',
"cable" = 'sound/vox/cable.wav',
"call" = 'sound/vox/call.wav',
"called" = 'sound/vox/called.wav',
"canal" = 'sound/vox/canal.wav',
"cap" = 'sound/vox/cap.wav',
"captain" = 'sound/vox/captain.wav',
"capture" = 'sound/vox/capture.wav',
"ceiling" = 'sound/vox/ceiling.wav',
"celsius" = 'sound/vox/celsius.wav',
"center" = 'sound/vox/center.wav',
"centi" = 'sound/vox/centi.wav',
"central" = 'sound/vox/central.wav',
"chamber" = 'sound/vox/chamber.wav',
"charlie" = 'sound/vox/charlie.wav',
"check" = 'sound/vox/check.wav',
"checkpoint" = 'sound/vox/checkpoint.wav',
"chemical" = 'sound/vox/chemical.wav',
"cleanup" = 'sound/vox/cleanup.wav',
"clear" = 'sound/vox/clear.wav',
"clearance" = 'sound/vox/clearance.wav',
"close" = 'sound/vox/close.wav',
"code" = 'sound/vox/code.wav',
"coded" = 'sound/vox/coded.wav',
"collider" = 'sound/vox/collider.wav',
"command" = 'sound/vox/command.wav',
"communication" = 'sound/vox/communication.wav',
"complex" = 'sound/vox/complex.wav',
"computer" = 'sound/vox/computer.wav',
"condition" = 'sound/vox/condition.wav',
"containment" = 'sound/vox/containment.wav',
"contamination" = 'sound/vox/contamination.wav',
"control" = 'sound/vox/control.wav',
"coolant" = 'sound/vox/coolant.wav',
"coomer" = 'sound/vox/coomer.wav',
"core" = 'sound/vox/core.wav',
"correct" = 'sound/vox/correct.wav',
"corridor" = 'sound/vox/corridor.wav',
"crew" = 'sound/vox/crew.wav',
"cross" = 'sound/vox/cross.wav',
"cryogenic" = 'sound/vox/cryogenic.wav',
"d" = 'sound/vox/d.wav',
"dadeda" = 'sound/vox/dadeda.wav',
"damage" = 'sound/vox/damage.wav',
"damaged" = 'sound/vox/damaged.wav',
"danger" = 'sound/vox/danger.wav',
"day" = 'sound/vox/day.wav',
"deactivated" = 'sound/vox/deactivated.wav',
"decompression" = 'sound/vox/decompression.wav',
"decontamination" = 'sound/vox/decontamination.wav',
"deeoo" = 'sound/vox/deeoo.wav',
"defense" = 'sound/vox/defense.wav',
"degrees" = 'sound/vox/degrees.wav',
"delta" = 'sound/vox/delta.wav',
"denied" = 'sound/vox/denied.wav',
"deploy" = 'sound/vox/deploy.wav',
"deployed" = 'sound/vox/deployed.wav',
"destroy" = 'sound/vox/destroy.wav',
"destroyed" = 'sound/vox/destroyed.wav',
"detain" = 'sound/vox/detain.wav',
"detected" = 'sound/vox/detected.wav',
"detonation" = 'sound/vox/detonation.wav',
"device" = 'sound/vox/device.wav',
"did" = 'sound/vox/did.wav',
"die" = 'sound/vox/die.wav',
"dimensional" = 'sound/vox/dimensional.wav',
"dirt" = 'sound/vox/dirt.wav',
"disengaged" = 'sound/vox/disengaged.wav',
"dish" = 'sound/vox/dish.wav',
"disposal" = 'sound/vox/disposal.wav',
"distance" = 'sound/vox/distance.wav',
"distortion" = 'sound/vox/distortion.wav',
"do" = 'sound/vox/do.wav',
"doctor" = 'sound/vox/doctor.wav',
"doop" = 'sound/vox/doop.wav',
"door" = 'sound/vox/door.wav',
"down" = 'sound/vox/down.wav',
"dual" = 'sound/vox/dual.wav',
"duct" = 'sound/vox/duct.wav',
"e" = 'sound/vox/e.wav',
"east" = 'sound/vox/east.wav',
"echo" = 'sound/vox/echo.wav',
"ed" = 'sound/vox/ed.wav',
"effect" = 'sound/vox/effect.wav',
"egress" = 'sound/vox/egress.wav',
"eight" = 'sound/vox/eight.wav',
"eighteen" = 'sound/vox/eighteen.wav',
"eighty" = 'sound/vox/eighty.wav',
"electric" = 'sound/vox/electric.wav',
"electromagnetic" = 'sound/vox/electromagnetic.wav',
"elevator" = 'sound/vox/elevator.wav',
"eleven" = 'sound/vox/eleven.wav',
"eliminate" = 'sound/vox/eliminate.wav',
"emergency" = 'sound/vox/emergency.wav',
"energy" = 'sound/vox/energy.wav',
"engage" = 'sound/vox/engage.wav',
"engaged" = 'sound/vox/engaged.wav',
"engine" = 'sound/vox/engine.wav',
"enter" = 'sound/vox/enter.wav',
"entry" = 'sound/vox/entry.wav',
"environment" = 'sound/vox/environment.wav',
"error" = 'sound/vox/error.wav',
"escape" = 'sound/vox/escape.wav',
"evacuate" = 'sound/vox/evacuate.wav',
"exchange" = 'sound/vox/exchange.wav',
"exit" = 'sound/vox/exit.wav',
"expect" = 'sound/vox/expect.wav',
"experiment" = 'sound/vox/experiment.wav',
"experimental" = 'sound/vox/experimental.wav',
"explode" = 'sound/vox/explode.wav',
"explosion" = 'sound/vox/explosion.wav',
"exposure" = 'sound/vox/exposure.wav',
"exterminate" = 'sound/vox/exterminate.wav',
"extinguish" = 'sound/vox/extinguish.wav',
"extinguisher" = 'sound/vox/extinguisher.wav',
"extreme" = 'sound/vox/extreme.wav',
"f" = 'sound/vox/f.wav',
"facility" = 'sound/vox/facility.wav',
"fahrenheit" = 'sound/vox/fahrenheit.wav',
"failed" = 'sound/vox/failed.wav',
"failure" = 'sound/vox/failure.wav',
"farthest" = 'sound/vox/farthest.wav',
"fast" = 'sound/vox/fast.wav',
"feet" = 'sound/vox/feet.wav',
"field" = 'sound/vox/field.wav',
"fifteen" = 'sound/vox/fifteen.wav',
"fifth" = 'sound/vox/fifth.wav',
"fifty" = 'sound/vox/fifty.wav',
"final" = 'sound/vox/final.wav',
"fine" = 'sound/vox/fine.wav',
"fire" = 'sound/vox/fire.wav',
"first" = 'sound/vox/first.wav',
"five" = 'sound/vox/five.wav',
"flooding" = 'sound/vox/flooding.wav',
"floor" = 'sound/vox/floor.wav',
"fool" = 'sound/vox/fool.wav',
"for" = 'sound/vox/for.wav',
"forbidden" = 'sound/vox/forbidden.wav',
"force" = 'sound/vox/force.wav',
"forms" = 'sound/vox/forms.wav',
"found" = 'sound/vox/found.wav',
"four" = 'sound/vox/four.wav',
"fourteen" = 'sound/vox/fourteen.wav',
"fourth" = 'sound/vox/fourth.wav',
"fourty" = 'sound/vox/fourty.wav',
"foxtrot" = 'sound/vox/foxtrot.wav',
"freeman" = 'sound/vox/freeman.wav',
"freezer" = 'sound/vox/freezer.wav',
"from" = 'sound/vox/from.wav',
"front" = 'sound/vox/front.wav',
"fuel" = 'sound/vox/fuel.wav',
"g" = 'sound/vox/g.wav',
"get" = 'sound/vox/get.wav',
"go" = 'sound/vox/go.wav',
"going" = 'sound/vox/going.wav',
"good" = 'sound/vox/good.wav',
"goodbye" = 'sound/vox/goodbye.wav',
"gordon" = 'sound/vox/gordon.wav',
"got" = 'sound/vox/got.wav',
"government" = 'sound/vox/government.wav',
"granted" = 'sound/vox/granted.wav',
"great" = 'sound/vox/great.wav',
"green" = 'sound/vox/green.wav',
"grenade" = 'sound/vox/grenade.wav',
"guard" = 'sound/vox/guard.wav',
"gulf" = 'sound/vox/gulf.wav',
"gun" = 'sound/vox/gun.wav',
"guthrie" = 'sound/vox/guthrie.wav',
"handling" = 'sound/vox/handling.wav',
"hangar" = 'sound/vox/hangar.wav',
"has" = 'sound/vox/has.wav',
"have" = 'sound/vox/have.wav',
"hazard" = 'sound/vox/hazard.wav',
"head" = 'sound/vox/head.wav',
"health" = 'sound/vox/health.wav',
"heat" = 'sound/vox/heat.wav',
"helicopter" = 'sound/vox/helicopter.wav',
"helium" = 'sound/vox/helium.wav',
"hello" = 'sound/vox/hello.wav',
"help" = 'sound/vox/help.wav',
"here" = 'sound/vox/here.wav',
"hide" = 'sound/vox/hide.wav',
"high" = 'sound/vox/high.wav',
"highest" = 'sound/vox/highest.wav',
"hit" = 'sound/vox/hit.wav',
"hole" = 'sound/vox/hole.wav',
"hostile" = 'sound/vox/hostile.wav',
"hot" = 'sound/vox/hot.wav',
"hotel" = 'sound/vox/hotel.wav',
"hour" = 'sound/vox/hour.wav',
"hours" = 'sound/vox/hours.wav',
"hundred" = 'sound/vox/hundred.wav',
"hydro" = 'sound/vox/hydro.wav',
"i" = 'sound/vox/i.wav',
"idiot" = 'sound/vox/idiot.wav',
"illegal" = 'sound/vox/illegal.wav',
"immediate" = 'sound/vox/immediate.wav',
"immediately" = 'sound/vox/immediately.wav',
"in" = 'sound/vox/in.wav',
"inches" = 'sound/vox/inches.wav',
"india" = 'sound/vox/india.wav',
"ing" = 'sound/vox/ing.wav',
"inoperative" = 'sound/vox/inoperative.wav',
"inside" = 'sound/vox/inside.wav',
"inspection" = 'sound/vox/inspection.wav',
"inspector" = 'sound/vox/inspector.wav',
"interchange" = 'sound/vox/interchange.wav',
"intruder" = 'sound/vox/intruder.wav',
"invallid" = 'sound/vox/invallid.wav',
"invasion" = 'sound/vox/invasion.wav',
"is" = 'sound/vox/is.wav',
"it" = 'sound/vox/it.wav',
"johnson" = 'sound/vox/johnson.wav',
"juliet" = 'sound/vox/juliet.wav',
"key" = 'sound/vox/key.wav',
"kill" = 'sound/vox/kill.wav',
"kilo" = 'sound/vox/kilo.wav',
"kit" = 'sound/vox/kit.wav',
"lab" = 'sound/vox/lab.wav',
"lambda" = 'sound/vox/lambda.wav',
"laser" = 'sound/vox/laser.wav',
"last" = 'sound/vox/last.wav',
"launch" = 'sound/vox/launch.wav',
"leak" = 'sound/vox/leak.wav',
"leave" = 'sound/vox/leave.wav',
"left" = 'sound/vox/left.wav',
"legal" = 'sound/vox/legal.wav',
"level" = 'sound/vox/level.wav',
"lever" = 'sound/vox/lever.wav',
"lie" = 'sound/vox/lie.wav',
"lieutenant" = 'sound/vox/lieutenant.wav',
"life" = 'sound/vox/life.wav',
"light" = 'sound/vox/light.wav',
"lima" = 'sound/vox/lima.wav',
"liquid" = 'sound/vox/liquid.wav',
"loading" = 'sound/vox/loading.wav',
"locate" = 'sound/vox/locate.wav',
"located" = 'sound/vox/located.wav',
"location" = 'sound/vox/location.wav',
"lock" = 'sound/vox/lock.wav',
"locked" = 'sound/vox/locked.wav',
"locker" = 'sound/vox/locker.wav',
"lockout" = 'sound/vox/lockout.wav',
"lower" = 'sound/vox/lower.wav',
"lowest" = 'sound/vox/lowest.wav',
"magnetic" = 'sound/vox/magnetic.wav',
"main" = 'sound/vox/main.wav',
"maintenance" = 'sound/vox/maintenance.wav',
"malfunction" = 'sound/vox/malfunction.wav',
"man" = 'sound/vox/man.wav',
"mass" = 'sound/vox/mass.wav',
"materials" = 'sound/vox/materials.wav',
"maximum" = 'sound/vox/maximum.wav',
"may" = 'sound/vox/may.wav',
"medical" = 'sound/vox/medical.wav',
"men" = 'sound/vox/men.wav',
"mercy" = 'sound/vox/mercy.wav',
"mesa" = 'sound/vox/mesa.wav',
"message" = 'sound/vox/message.wav',
"meter" = 'sound/vox/meter.wav',
"micro" = 'sound/vox/micro.wav',
"middle" = 'sound/vox/middle.wav',
"mike" = 'sound/vox/mike.wav',
"miles" = 'sound/vox/miles.wav',
"military" = 'sound/vox/military.wav',
"milli" = 'sound/vox/milli.wav',
"million" = 'sound/vox/million.wav',
"minefield" = 'sound/vox/minefield.wav',
"minimum" = 'sound/vox/minimum.wav',
"minutes" = 'sound/vox/minutes.wav',
"mister" = 'sound/vox/mister.wav',
"mode" = 'sound/vox/mode.wav',
"motor" = 'sound/vox/motor.wav',
"motorpool" = 'sound/vox/motorpool.wav',
"move" = 'sound/vox/move.wav',
"must" = 'sound/vox/must.wav',
"nearest" = 'sound/vox/nearest.wav',
"nice" = 'sound/vox/nice.wav',
"nine" = 'sound/vox/nine.wav',
"nineteen" = 'sound/vox/nineteen.wav',
"ninety" = 'sound/vox/ninety.wav',
"no" = 'sound/vox/no.wav',
"nominal" = 'sound/vox/nominal.wav',
"north" = 'sound/vox/north.wav',
"not" = 'sound/vox/not.wav',
"november" = 'sound/vox/november.wav',
"now" = 'sound/vox/now.wav',
"number" = 'sound/vox/number.wav',
"objective" = 'sound/vox/objective.wav',
"observation" = 'sound/vox/observation.wav',
"of" = 'sound/vox/of.wav',
"officer" = 'sound/vox/officer.wav',
"ok" = 'sound/vox/ok.wav',
"on" = 'sound/vox/on.wav',
"one" = 'sound/vox/one.wav',
"open" = 'sound/vox/open.wav',
"operating" = 'sound/vox/operating.wav',
"operations" = 'sound/vox/operations.wav',
"operative" = 'sound/vox/operative.wav',
"option" = 'sound/vox/option.wav',
"order" = 'sound/vox/order.wav',
"organic" = 'sound/vox/organic.wav',
"oscar" = 'sound/vox/oscar.wav',
"out" = 'sound/vox/out.wav',
"outside" = 'sound/vox/outside.wav',
"over" = 'sound/vox/over.wav',
"overload" = 'sound/vox/overload.wav',
"override" = 'sound/vox/override.wav',
"pacify" = 'sound/vox/pacify.wav',
"pain" = 'sound/vox/pain.wav',
"pal" = 'sound/vox/pal.wav',
"panel" = 'sound/vox/panel.wav',
"percent" = 'sound/vox/percent.wav',
"perimeter" = 'sound/vox/perimeter.wav',
"permitted" = 'sound/vox/permitted.wav',
"personnel" = 'sound/vox/personnel.wav',
"pipe" = 'sound/vox/pipe.wav',
"plant" = 'sound/vox/plant.wav',
"platform" = 'sound/vox/platform.wav',
"please" = 'sound/vox/please.wav',
"point" = 'sound/vox/point.wav',
"portal" = 'sound/vox/portal.wav',
"power" = 'sound/vox/power.wav',
"presence" = 'sound/vox/presence.wav',
"press" = 'sound/vox/press.wav',
"primary" = 'sound/vox/primary.wav',
"proceed" = 'sound/vox/proceed.wav',
"processing" = 'sound/vox/processing.wav',
"progress" = 'sound/vox/progress.wav',
"proper" = 'sound/vox/proper.wav',
"propulsion" = 'sound/vox/propulsion.wav',
"prosecute" = 'sound/vox/prosecute.wav',
"protective" = 'sound/vox/protective.wav',
"push" = 'sound/vox/push.wav',
"quantum" = 'sound/vox/quantum.wav',
"quebec" = 'sound/vox/quebec.wav',
"question" = 'sound/vox/question.wav',
"questioning" = 'sound/vox/questioning.wav',
"quick" = 'sound/vox/quick.wav',
"quit" = 'sound/vox/quit.wav',
"radiation" = 'sound/vox/radiation.wav',
"radioactive" = 'sound/vox/radioactive.wav',
"rads" = 'sound/vox/rads.wav',
"rapid" = 'sound/vox/rapid.wav',
"reach" = 'sound/vox/reach.wav',
"reached" = 'sound/vox/reached.wav',
"reactor" = 'sound/vox/reactor.wav',
"red" = 'sound/vox/red.wav',
"relay" = 'sound/vox/relay.wav',
"released" = 'sound/vox/released.wav',
"remaining" = 'sound/vox/remaining.wav',
"renegade" = 'sound/vox/renegade.wav',
"repair" = 'sound/vox/repair.wav',
"report" = 'sound/vox/report.wav',
"reports" = 'sound/vox/reports.wav',
"required" = 'sound/vox/required.wav',
"research" = 'sound/vox/research.wav',
"resevoir" = 'sound/vox/resevoir.wav',
"resistance" = 'sound/vox/resistance.wav',
"right" = 'sound/vox/right.wav',
"rocket" = 'sound/vox/rocket.wav',
"roger" = 'sound/vox/roger.wav',
"romeo" = 'sound/vox/romeo.wav',
"room" = 'sound/vox/room.wav',
"round" = 'sound/vox/round.wav',
"run" = 'sound/vox/run.wav',
"safe" = 'sound/vox/safe.wav',
"safety" = 'sound/vox/safety.wav',
"sargeant" = 'sound/vox/sargeant.wav',
"satellite" = 'sound/vox/satellite.wav',
"save" = 'sound/vox/save.wav',
"science" = 'sound/vox/science.wav',
"scream" = 'sound/vox/scream.wav',
"screen" = 'sound/vox/screen.wav',
"search" = 'sound/vox/search.wav',
"second" = 'sound/vox/second.wav',
"secondary" = 'sound/vox/secondary.wav',
"seconds" = 'sound/vox/seconds.wav',
"sector" = 'sound/vox/sector.wav',
"secure" = 'sound/vox/secure.wav',
"secured" = 'sound/vox/secured.wav',
"security" = 'sound/vox/security.wav',
"select" = 'sound/vox/select.wav',
"selected" = 'sound/vox/selected.wav',
"service" = 'sound/vox/service.wav',
"seven" = 'sound/vox/seven.wav',
"seventeen" = 'sound/vox/seventeen.wav',
"seventy" = 'sound/vox/seventy.wav',
"severe" = 'sound/vox/severe.wav',
"sewage" = 'sound/vox/sewage.wav',
"sewer" = 'sound/vox/sewer.wav',
"shield" = 'sound/vox/shield.wav',
"shipment" = 'sound/vox/shipment.wav',
"shock" = 'sound/vox/shock.wav',
"shoot" = 'sound/vox/shoot.wav',
"shower" = 'sound/vox/shower.wav',
"shut" = 'sound/vox/shut.wav',
"side" = 'sound/vox/side.wav',
"sierra" = 'sound/vox/sierra.wav',
"sight" = 'sound/vox/sight.wav',
"silo" = 'sound/vox/silo.wav',
"six" = 'sound/vox/six.wav',
"sixteen" = 'sound/vox/sixteen.wav',
"sixty" = 'sound/vox/sixty.wav',
"slime" = 'sound/vox/slime.wav',
"slow" = 'sound/vox/slow.wav',
"soldier" = 'sound/vox/soldier.wav',
"some" = 'sound/vox/some.wav',
"someone" = 'sound/vox/someone.wav',
"something" = 'sound/vox/something.wav',
"son" = 'sound/vox/son.wav',
"sorry" = 'sound/vox/sorry.wav',
"south" = 'sound/vox/south.wav',
"squad" = 'sound/vox/squad.wav',
"square" = 'sound/vox/square.wav',
"stairway" = 'sound/vox/stairway.wav',
"status" = 'sound/vox/status.wav',
"sterile" = 'sound/vox/sterile.wav',
"sterilization" = 'sound/vox/sterilization.wav',
"storage" = 'sound/vox/storage.wav',
"sub" = 'sound/vox/sub.wav',
"subsurface" = 'sound/vox/subsurface.wav',
"sudden" = 'sound/vox/sudden.wav',
"suit" = 'sound/vox/suit.wav',
"superconducting" = 'sound/vox/superconducting.wav',
"supercooled" = 'sound/vox/supercooled.wav',
"supply" = 'sound/vox/supply.wav',
"surface" = 'sound/vox/surface.wav',
"surrender" = 'sound/vox/surrender.wav',
"surround" = 'sound/vox/surround.wav',
"surrounded" = 'sound/vox/surrounded.wav',
"switch" = 'sound/vox/switch.wav',
"system" = 'sound/vox/system.wav',
"systems" = 'sound/vox/systems.wav',
"tactical" = 'sound/vox/tactical.wav',
"take" = 'sound/vox/take.wav',
"talk" = 'sound/vox/talk.wav',
"tango" = 'sound/vox/tango.wav',
"tank" = 'sound/vox/tank.wav',
"target" = 'sound/vox/target.wav',
"team" = 'sound/vox/team.wav',
"temperature" = 'sound/vox/temperature.wav',
"temporal" = 'sound/vox/temporal.wav',
"ten" = 'sound/vox/ten.wav',
"terminal" = 'sound/vox/terminal.wav',
"terminated" = 'sound/vox/terminated.wav',
"termination" = 'sound/vox/termination.wav',
"test" = 'sound/vox/test.wav',
"that" = 'sound/vox/that.wav',
"the" = 'sound/vox/the.wav',
"then" = 'sound/vox/then.wav',
"there" = 'sound/vox/there.wav',
"third" = 'sound/vox/third.wav',
"thirteen" = 'sound/vox/thirteen.wav',
"thirty" = 'sound/vox/thirty.wav',
"this" = 'sound/vox/this.wav',
"those" = 'sound/vox/those.wav',
"thousand" = 'sound/vox/thousand.wav',
"threat" = 'sound/vox/threat.wav',
"three" = 'sound/vox/three.wav',
"through" = 'sound/vox/through.wav',
"time" = 'sound/vox/time.wav',
"to" = 'sound/vox/to.wav',
"top" = 'sound/vox/top.wav',
"topside" = 'sound/vox/topside.wav',
"touch" = 'sound/vox/touch.wav',
"towards" = 'sound/vox/towards.wav',
"track" = 'sound/vox/track.wav',
"train" = 'sound/vox/train.wav',
"transportation" = 'sound/vox/transportation.wav',
"truck" = 'sound/vox/truck.wav',
"tunnel" = 'sound/vox/tunnel.wav',
"turn" = 'sound/vox/turn.wav',
"turret" = 'sound/vox/turret.wav',
"twelve" = 'sound/vox/twelve.wav',
"twenty" = 'sound/vox/twenty.wav',
"two" = 'sound/vox/two.wav',
"unauthorized" = 'sound/vox/unauthorized.wav',
"under" = 'sound/vox/under.wav',
"uniform" = 'sound/vox/uniform.wav',
"unlocked" = 'sound/vox/unlocked.wav',
"until" = 'sound/vox/until.wav',
"up" = 'sound/vox/up.wav',
"upper" = 'sound/vox/upper.wav',
"uranium" = 'sound/vox/uranium.wav',
"us" = 'sound/vox/us.wav',
"usa" = 'sound/vox/usa.wav',
"use" = 'sound/vox/use.wav',
"used" = 'sound/vox/used.wav',
"user" = 'sound/vox/user.wav',
"vacate" = 'sound/vox/vacate.wav',
"valid" = 'sound/vox/valid.wav',
"vapor" = 'sound/vox/vapor.wav',
"vent" = 'sound/vox/vent.wav',
"ventillation" = 'sound/vox/ventillation.wav',
"victor" = 'sound/vox/victor.wav',
"violated" = 'sound/vox/violated.wav',
"violation" = 'sound/vox/violation.wav',
"voltage" = 'sound/vox/voltage.wav',
"vox_login" = 'sound/vox/vox_login.wav',
"walk" = 'sound/vox/walk.wav',
"wall" = 'sound/vox/wall.wav',
"want" = 'sound/vox/want.wav',
"wanted" = 'sound/vox/wanted.wav',
"warm" = 'sound/vox/warm.wav',
"warn" = 'sound/vox/warn.wav',
"warning" = 'sound/vox/warning.wav',
"waste" = 'sound/vox/waste.wav',
"water" = 'sound/vox/water.wav',
"we" = 'sound/vox/we.wav',
"weapon" = 'sound/vox/weapon.wav',
"west" = 'sound/vox/west.wav',
"whiskey" = 'sound/vox/whiskey.wav',
"white" = 'sound/vox/white.wav',
"wilco" = 'sound/vox/wilco.wav',
"will" = 'sound/vox/will.wav',
"with" = 'sound/vox/with.wav',
"without" = 'sound/vox/without.wav',
"woop" = 'sound/vox/woop.wav',
"xeno" = 'sound/vox/xeno.wav',
"yankee" = 'sound/vox/yankee.wav',
"yards" = 'sound/vox/yards.wav',
"year" = 'sound/vox/year.wav',
"yellow" = 'sound/vox/yellow.wav',
"yes" = 'sound/vox/yes.wav',
"you" = 'sound/vox/you.wav',
"your" = 'sound/vox/your.wav',
"yourself" = 'sound/vox/yourself.wav',
"zero" = 'sound/vox/zero.wav',
"zone" = 'sound/vox/zone.wav',
"zulu" = 'sound/vox/zulu.wav'*/)