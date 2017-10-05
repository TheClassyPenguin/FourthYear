
(deftemplate Personaje
	(slot nombre_Personaje)
    ;stats
	(slot int (allowed-values nil yes no))
	(slot finesse(allowed-values nil yes no))
    (slot wit(allowed-values nil yes no))
    (slot str(allowed-values nil yes no))
    (slot con(allowed-values nil yes no))
    ;damage type
    (slot magic(allowed-values nil yes no))
    (slot elemental(allowed-values nil yes no))
    (slot physical(allowed-values nil yes no))
    (slot bleed(allowed-values nil yes no))
    (slot disease(allowed-values nil yes no))
    ;range
    (slot short(allowed-values nil yes no))
    (slot medium(allowed-values nil yes no))
    (slot long(allowed-values nil yes no))
    ;role
    (slot mage(allowed-values nil yes no))
    (slot tank(allowed-values nil yes no))
    (slot archer(allowed-values nil yes no))
    (slot healer(allowed-values nil yes no))
    (slot summoner(allowed-values nil yes no))
    (slot crowdControl(allowed-values nil yes no))
    (slot buffer(allowed-values nil yes no))
    (slot warrior(allowed-values nil yes no))
    (slot tank(allowed-values nil yes no))
    (slot rogue(allowed-values nil yes no))
    ;Deduction
    (slot deduction (default nil))
)

(set-strategy depth)
(do-backward-chaining Personaje)

(deffacts ejemplo
	(Personaje(nombre_Personaje Boromir)(tank yes))
	(Personaje(nombre_Personaje Legolas))
	(Personaje(nombre_Personaje Gandalf))
)

;Final deduction
(defrule Aerotheurge (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(int yes)(magic yes)(elemental yes)(long yes)(mage yes))
    =>	(printout t  ?nombre " es un Aerotheurge" ?newline ?newline)
		(modify ?personaje (deduction yes)))

(defrule Geomancer (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(int yes)(con yes)(physical yes)(elemental yes)(medium yes)(mage yes)(tank yes))
    =>	(printout t ?nombre " es un Geomancer" ?newline ?newline)
		(modify ?personaje (deduction yes)))

(defrule Hunstman (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(finesse yes)(wit yes)(physical yes)(long yes)(archer yes))
    =>	(printout t ?nombre " es un Huntsman" ?newline ?newline)
    	(modify ?personaje (deduction yes)))

(defrule Hydrosophist (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(int yes)(magic yes)(elemental yes)(long yes)(mage yes)(healer yes))
    =>	(printout t ?nombre " es un Hydrosophist" ?newline ?newline)
    	(modify ?personaje (deduction yes)))

(defrule Necromancer (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(int yes)(wit yes)(physical yes)(bleed yes)(disease yes)(medium yes)(summoner yes)(mage yes))
    =>	(printout t ?nombre " es un Necromancer" ?newline ?newline)
    	(modify ?personaje (deduction yes)))

(defrule Polymorph (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(wit yes)(physical yes)(medium yes)(mage yes)(crowdControl yes)(buffer yes))
    =>	(printout t  ?nombre " es un Polymorph" ?newline ?newline)
    	(modify ?personaje (deduction yes)))

(defrule Pyrokinetic (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(int yes)(magic yes)(elemental yes)(long yes)(mage yes)(buffer yes))
    =>	(printout t  ?nombre " es un Pyrokinetic" ?newline ?newline)
    	(modify ?personaje (deduction yes)))

(defrule Scoundrel (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(finesse yes)(wit yes)(physical yes)(short yes)(rogue yes)(crowdControl yes))
    =>	(printout t  ?nombre " es un Scoundrel" ?newline ?newline)
    	(modify ?personaje (deduction yes)))

(defrule Summoning (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(int yes)(con yes)(magic yes)(elemental yes)(medium yes)(summoner yes)(buffer yes)(mage yes))
    =>	(printout t  ?nombre " es un Summoner" ?newline ?newline)
    	(modify ?personaje (deduction yes)))

(defrule Warfare (declare (salience 100)(no-loop TRUE))
    ?personaje<- (Personaje (nombre_Personaje ?nombre)(deduction nil)(str yes)(con yes)(physical yes)(short yes)(short yes)(warrior yes)(tank yes))
    =>	(printout t  ?nombre " es un Warfare" ?newline ?newline)
    	(modify ?personaje (deduction yes)))

;Deduction rules

;Relación rol -> Estadistica

(defrule intMage (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(mage yes))
    =>  (modify ?personaje (int yes))
    	(printout t ?nombre "es mago y por lo tanto utiliza INT" ?newline))

(defrule conTank (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(tank yes))
    =>  (modify ?personaje (con yes))
    	(printout t ?nombre "" ?newline))

(defrule strWarrior (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(warrior yes))
    =>  (modify ?personaje (str yes)(con yes))
    	(printout t ?nombre "es warrior y por lo tanto utiliza STR+CON" ?newline))

(defrule finesseRogue (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(rogue yes))
    =>  (modify ?personaje (finesse yes))
    	(printout t ?nombre "es rogue y por lo tanto utiliza FINESSE" ?newline))

(defrule finesseArcher (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(archer yes))
    =>  (modify ?personaje (finesse yes)(wit yes))
    	(printout t ?nombre "es archer y por lo tanto utiliza FINESSE+WIT" ?newline))

(defrule intBuffer (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(buffer yes))
    =>  (modify ?personaje (int yes))
    	(printout t ?nombre "es buffer y por lo tanto utiliza INT" ?newline))

(defrule intSummoner (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(summoner yes))
    =>  (modify ?personaje (int yes))
    	(printout t ?nombre "es summoner y por lo tanto utiliza INT" ?newline))

;Relación Estadística -> rol

(defrule tankCON (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(tank yes))
    =>  (modify ?personaje (con yes))
    	(printout t ?nombre "utiliza CON y por lo tanto es un tanque" ?newline))

(defrule warriorSTR (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(str yes))
    =>  (modify ?personaje (warrior yes)(tank yes))
    	(printout t ?nombre "utiliza STR y por lo tanto es un tanque y un guerrero" ?newline))

;Relación rol -> rango

(defrule longMage (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(mage yes))
    =>  (modify ?personaje (long yes))
    	(printout t ?nombre " es mago y por lo tanto utiliza INT" ?newline))

(defrule shortTank (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(tank yes))
    =>  (modify ?personaje (short yes))
    	(printout t ?nombre " es tanque y por lo tanto tiene corto alcance" ?newline))

(defrule shortWarrior (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(warrior yes))
    =>  (modify ?personaje (short yes))
    	(printout t ?nombre " es warrior y por lo tanto tiene corto alcance" ?newline))

(defrule shortRogue (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(rogue yes))
    =>  (modify ?personaje (short yes))
    	(printout t ?nombre " es rogue y por lo tanto tiene corto alcance" ?newline))

(defrule longArcher (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(archer yes))
    =>  (modify ?personaje (long yes))
    	(printout t ?nombre " es archer y por lo tanto tiene largo alcance" ?newline))

(defrule mediumBuffer (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(buffer yes))
    =>  (modify ?personaje (medium yes))
    	(printout t ?nombre " es buffer y por lo tanto tiene medio alcance" ?newline))

(defrule mediumSummoner (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(summoner yes))
    =>  (modify ?personaje (medium yes))
    	(printout t ?nombre " es summoner y por lo tanto tiene medio alcance" ?newline))

;Relación rol -> tipo de daño

(defrule elementalMage (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(mage yes))
    =>  (modify ?personaje (elemental yes))
    	(printout t ?nombre "es mago y hace daño de tipo elemental" ?newline))

(defrule magicMage (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(mage yes))
    =>  (modify ?personaje (magic yes))
    	(printout t ?nombre "es mago y hace daño de tipo magico" ?newline))

(defrule physicalTank (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(tank yes))
    =>  (modify ?personaje (physical yes))
    	(printout t ?nombre "es tanque y hace daño de tipo físico" ?newline))

(defrule physicalWarrior (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(warrior yes))
    =>  (modify ?personaje (physical yes))
    	(printout t ?nombre "es warrior y hace daño de tipo fisico" ?newline))

(defrule physicalRogue (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(rogue yes))
    =>  (modify ?personaje (physical yes))
    	(printout t ?nombre "es rogue y hace daño de tipo fisico" ?newline))

(defrule physicalArcher (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(archer yes))
    =>  (modify ?personaje (physical yes))
    	(printout t ?nombre "es archer y hace daño de tipo fisico" ?newline))

(defrule magicHealer (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(healer yes))
    =>  (modify ?personaje (magic yes))
    	(printout t ?nombre "es healer y hace daño de tipo magico" ?newline))

(defrule physicalCrowdControl (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(crowdControl yes))
    =>  (modify ?personaje (physical yes))
    	(printout t ?nombre "es crowdControl y hace daño de tipo fisico" ?newline))

;Relación stats -> rango
(defrule strShort (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(str yes))
    =>  (modify ?personaje (short yes))
    	(printout t ?nombre "usa str y tiene un rango corto" ?newline))

;Relación rango -> stats
(defrule shortSTR (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(short yes))
    =>  (modify ?personaje (str yes))
    	(printout t ?nombre "tiene rango corto y usa str" ?newline))

; Relación daño -> daño

(defrule physicalNOTmagic (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(physical yes))
    =>  (modify ?personaje (magic no)(elemental no))
    	(printout t ?nombre " usa daño fisico y por lo tanto no usa daño elemental ni mágico" ?newline))
    	
(defrule magicNOTphysicalButElemental (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(magic yes))
    =>  (modify ?personaje (physical no)(elemental yes))
    	(printout t ?nombre " usa daño fisico y por lo tanto no usa daño elemental ni mágico" ?newline))
    	
 (defrule elementalISMagic (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(elemental yes))
    =>  (modify ?personaje (magic yes))
    	(printout t ?nombre " usa daño elemental el cual es de tipo mágico." ?newline))

(defrule bleedISPhysicalANDDisease (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(bleed yes))
    =>  (modify ?personaje (physical yes)(disease yes))
    	(printout t ?nombre " usa daño bleed y por lo tanto hace daño del tipo desease y physical" ?newline))
 
 (defrule diseaseISPhysicalANDbleed (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(disease yes))
    =>  (modify ?personaje (physical yes)(bleed yes))
    	(printout t ?nombre " usa daño disease y por lo tanto hace daño del tipo bleed y physical" ?newline))

;relación stat -> stat

(defrule STRNOTINTNOTDEX (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(str yes))
    =>  (modify ?personaje (int no)(finesse no))
    	(printout t ?nombre " usa fuerza y por lo tanto no usa inteligencia ni finesse" ?newline))
    	
(defrule INTNOTSTRNOTDEX (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(int yes))
    =>  (modify ?personaje (str no)(finesse no))
    	(printout t ?nombre " usa inteligencia y por lo tanto no usa fuerza ni finesse" ?newline))
    	
(defrule DEXNOTSTRNOTINT (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(finesse yes))
    =>  (modify ?personaje (str no)(int no))
    	(printout t ?nombre " usa inteligencia y por lo tanto no usa fuerza ni finesse" ?newline))

(defrule WITNOTCON (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(wit yes))
    =>  (modify ?personaje (con no))
    	(printout t ?nombre " usa WIT y por lo tanto no usa CON" ?newline))

(defrule CONNOTWIT (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(con yes))
    =>  (modify ?personaje (wit no))
    	(printout t ?nombre " usa CON y por lo tanto no usa WIT" ?newline))

; Relation role -> role

(defrule mageLock (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(mage yes))
    =>  (modify ?personaje (warrior no)(tank no)(rogue no)(archer no))
    	(printout t ?nombre " es mago y por lo tanto no puede ser ni guerrero ni tanque ni rogue." ?newline))
    	
(defrule summonerLock (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(summoner yes))
    =>  (modify ?personaje (mage yes))
    	(printout t ?nombre " es summoner y por lo tanto es un mago." ?newline))
    	
(defrule healerLock (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(healer yes))
    =>  (modify ?personaje (mage yes))
    	(printout t ?nombre " es healer y por lo tanto es un mago." ?newline))
    	
(defrule bufferLock (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(buffer yes))
    =>  (modify ?personaje (mage yes))
    	(printout t ?nombre " es buffer y por lo tanto es un mago." ?newline))

(defrule crowdControlLock (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(crowdControl yes))
    =>  (modify ?personaje (warrior no)(tank no)(archer no)(summoner no)(healer no))
    	(printout t ?nombre " es crowdControl y por lo tanto no es warrior ni tanque ni archer ni summoner." ?newline))

(defrule rogueLock (no-loop TRUE)
	?personaje <- (Personaje (nombre_Personaje ?nombre)(deduction nil)(rogue yes))
    =>  (modify ?personaje (warrior no)(tank no)(archer no)(mage no)(summoner no))
    	(printout t ?nombre " es rogue y por lo tanto no puede ser ni guerrero ni tanque ni arquero ni mago ni summoner." ?newline))


;Preguntas al usuario

; Ask role

(defrule askRoleMage 
	(declare (salience -1100))
	(exists (Personaje (nombre_Personaje ?nombre) (mage nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (mage nil) (deduction nil))
 => (printout t "Is " ?nombre " a mage? (yes/no):")
 	(modify ?personaje (mage (read)))) 

(defrule askRolewarrior 
	(declare (salience -1000))
	(exists (Personaje (nombre_Personaje ?nombre) (warrior nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (warrior nil) (deduction nil))
 => (printout t "Is " ?nombre " a warrior? (yes/no):")
 	(modify ?personaje (warrior (read))))

 (defrule askRoleHealer 
	(declare (salience -1000))
	(exists (Personaje (nombre_Personaje ?nombre) (healer nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (healer nil) (deduction nil))
 => (printout t "Is " ?nombre " a healer? (yes/no):")
 	(modify ?personaje (healer (read))))

(defrule askRoleRogue 
	(declare (salience -1000))
	(exists (Personaje (nombre_Personaje ?nombre) (rogue nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (rogue nil) (deduction nil))
 => (printout t "Is " ?nombre " a rogue? (yes/no):")
 	(modify ?personaje (rogue (read))))
 	
 (defrule askRoleTank 
	(declare (salience -1100))
	(exists (Personaje (nombre_Personaje ?nombre) (tank nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (tank nil) (deduction nil))
 => (printout t "Is " ?nombre " a tank? (yes/no):")
 	(modify ?personaje (tank (read)))) 
  	
(defrule askRoleArcher 
	(declare (salience -1000))
	(exists (Personaje (nombre_Personaje ?nombre) (archer nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (archer nil) (deduction nil))
 => (printout t "Is " ?nombre " an archer? (yes/no):")
 	(modify ?personaje (archer (read)))) 
 	
(defrule askRolebuffer 
	(declare (salience -1000))
	(exists (Personaje (nombre_Personaje ?nombre) (buffer nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (buffer nil) (deduction nil))
 => (printout t "Is " ?nombre " a buffer? (yes/no):")
 	(modify ?personaje (buffer (read))))
 	
(defrule askRolecrowdControl 
	(declare (salience -1000))
	(exists (Personaje (nombre_Personaje ?nombre) (crowdControl nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (crowdControl nil) (deduction nil))
 => (printout t "Is " ?nombre " a crowdControl? (yes/no):")
 	(modify ?personaje (crowdControl (read))))

(defrule askRolesummoner 
	(declare (salience -1000))
	(exists (Personaje (nombre_Personaje ?nombre) (summoner nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (summoner nil) (deduction nil))
 => (printout t "Is " ?nombre " a summoner? (yes/no):")
 	(modify ?personaje (summoner (read))))
 
 ;Ask Damage type
 
 (defrule askDMGdisease 
	(declare (salience -90))
	(exists (Personaje (nombre_Personaje ?nombre) (disease nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (disease nil) (deduction nil))
 => (printout t "Does " ?nombre "deal disease damage? (yes/no):")
 	(modify ?personaje (disease (read))))
 
 (defrule askDMGmagic 
	(declare (salience -90))
	(exists (Personaje (nombre_Personaje ?nombre) (magic nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (magic nil) (deduction nil))
 => (printout t "Does " ?nombre "deal magic damage? (yes/no):")
 	(modify ?personaje (magic (read))))
 	
 (defrule askDMGelemental 
	(declare (salience -90))
	(exists (Personaje (nombre_Personaje ?nombre) (elemental nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (elemental nil) (deduction nil))
 => (printout t "Does " ?nombre "deal elemental damage? (yes/no):")
 	(modify ?personaje (elemental (read))))
 	
  (defrule askDMGphysical 
	(declare (salience -90))
	(exists (Personaje (nombre_Personaje ?nombre) (physical nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (physical nil) (deduction nil))
 => (printout t "Does " ?nombre "deal physical damage? (yes/no):")
 	(modify ?personaje (physical (read))))
 
  (defrule askDMGbleed 
	(declare (salience -90))
	(exists (Personaje (nombre_Personaje ?nombre) (bleed nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (bleed nil) (deduction nil))
 => (printout t "Does " ?nombre "deal bleed damage? (yes/no):")
 	(modify ?personaje (bleed (read))))
 	
 ; Ask range
 
(defrule askRANGEshort 
	(declare (salience -100))
	(exists (Personaje (nombre_Personaje ?nombre) (short nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (short nil) (deduction nil))
 => (printout t "Does " ?nombre " like to deal damage at short range? (yes/no):")
 	(modify ?personaje (short (read))))
 
(defrule askRANGEmedium 
	(declare (salience -100))
	(exists (Personaje (nombre_Personaje ?nombre) (medium nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (medium nil) (deduction nil))
 => (printout t "Does " ?nombre " like to deal damage at medium range? (yes/no):")
 	(modify ?personaje (medium (read))))
 	
(defrule askRANGElong 
	(declare (salience -100))
	(exists (Personaje (nombre_Personaje ?nombre) (long nil)))
 	?personaje <- (Personaje (nombre_Personaje ?nombre) (long nil) (deduction nil))
 => (printout t "Does " ?nombre " like to deal damage at long range? (yes/no):")
 	(modify ?personaje (long (read))))
 	
(reset)
(bind ?newline (call java.lang.System getProperty "line.separator")) 
(run)