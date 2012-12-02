namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Step 1: initial set-up
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate to set up db structure based on latest migrations
    Rake::Task['db:migrate'].invoke
    
    # Get two gems needed to make this work: faker & populator
    require 'populator'   # Docs at: http://populator.rubyforge.org/
    require 'faker'       # Docs at: http://faker.rubyforge.org/rdoc/
    
    # -----------------------    
    # Step 2: add some animal types to work with (small set for now...)
    animals = %w[Bird Cat Dog Ferret Rabbit]
    animals.sort.each do |animal|
      a = Animal.new
      a.name = animal
      a.active = true
      a.save!
    end
    # get an array of animal_ids to use later
    animal_ids = Animal.alphabetical.all.map{|a| a.id}
    
    # -----------------------
    # Step 3: add some procedures (and associated costs) that PATS will offer
    procedures = {"Check-up" => [30,12500], 
                 "Examination" => [30,15000], 
                 "X-ray" => [10,5000], 
                 "Grooming" => [15,4000], 
                 "Testing" => [10,15000], 
                 "Minor Surgery" => [75,40000], 
                 "Major Surgery" => [180,120000], 
                 "Observation" => [180,7500], 
                 "Observation, Extended" => [540,15000]
                 }
    procedures.sort.each do |procedure, vars|
      p = Procedure.new
      p.name = procedure
      p.description = "An amazing procedure"
      p.length_of_time = vars[0].to_i
      p.active = true
      p.save!
      
      # add current cost of procedure
      pc = ProcedureCost.new
      pc.procedure_id = p.id
      pc.cost = vars[1].to_i
      started = rand(4) + 2
      pc.start_date = started.months.ago.to_date
      pc.end_date = nil
      pc.save!
      
      # add one older cost
      pc_older = ProcedureCost.new
      pc_older.procedure_id = p.id
      pc_older.cost = (((vars[1].to_i/100) * (0.9))*100).to_i 
      originally_started = rand(3) + 7
      pc_older.start_date = originally_started.months.ago.to_date
      pc_older.end_date = pc.start_date
      pc_older.save!
      
    end
    # get an array of procedure_ids to use later
    procedure_ids = Procedure.alphabetical.all.map{|p| p.id}
    
    # -----------------------
    # Step 4: add some medicines that PATS will offer
    medicines = {"Carprofen" => [[3],"Used to relieve pain and inflammation in dogs. Annedotal reports of severe GI effects in cats."], 
                 "Deracoxib" => [[1,2,3,4,5],"Post operative pain management and osteoarthritis. Interest in use as adjunctive treatment to transitional cell carcinoma."], 
                 "Ivermectin" => [[3],"A broad-spectrum antiparasitic used in horses and dogs."], 
                 "Ketamine" => [[2,3],"Anesthetic and tranquilizer in cats, dogs, horses, and other animals"], 
                 "Mirtazapine" => [[2,3],"Antiemetic and appetite stimulant in cats and dog"], 
                 "Amoxicillin" => [[1,2,3,4,5],"Antibiotic indicated for susceptible gram positive and gram negative infections. Ineffective against species that produce beta-lactamase."], 
                 "Aureomycin" => [[1],"For use in birds for the treatment of bacterial pneumonia and bacterial enteritis."], 
                 "Pimobendan" => [[3],"Used to manage heart failure in dogs"], 
                 "Ntroscanate" => [[2,3,4,5],"Anthelmintic used to treat Toxocara canis, Toxascaris leonina, Ancylostoma caninum, Uncinaria stenocephalia, Taenia, and Dipylidium caninum (roundworms, hookworms and tapeworms)."],
                 "Buprenorphine" => [[2],"Narcotic for pain relief in cats after surgery."]
                 }
    medicines.each do |medicine, vars|
      m = Medicine.new
      m.name = medicine
      m.description = vars[1]
      m.unit = ['mililiters', 'miligrams'].sample
      m.method = ['oral','injection','intravenous'].sample
      m.stock_amount = rand(5000) + 2000
      m.vaccine = false
      m.save!
      
      # link the medicine to relevant species
      vars[0].each do |a_id|
        am = AnimalMedicine.new
        am.medicine_id = m.id
        am.animal_id = a_id
        am.recommended_num_of_units = nil
        am.save!
      end
      
      # add current cost of medicine
      mc = MedicineCost.new
      mc.medicine_id = m.id
      mc.cost_per_unit = rand(50) + 20
      started = rand(4) + 2
      mc.start_date = started.months.ago.to_date
      mc.end_date = nil
      mc.save!
      
      # add one older cost
      mc_older = MedicineCost.new
      mc_older.medicine_id = m.id
      mc_older.cost_per_unit = mc.cost_per_unit - (10 - rand(5)) 
      originally_started = rand(3) + 7
      mc_older.start_date = originally_started.months.ago.to_date
      mc_older.end_date = mc.start_date
      mc_older.save!
    end
    # get an array of medicine_ids to use later
    medicine_ids = Medicine.alphabetical.all.map{|m| m.id}
    
    # -----------------------
    # Step 5: add 120 owners to the system and associated pets
    Owner.populate 120 do |owner|
      # get some fake data using the Faker gem
      owner.first_name = Faker::Name.first_name
      owner.last_name = Faker::Name.last_name
      owner.street = Faker::Address.street_address
      city_zip = [["Pittsburgh",15213],["Pittsburgh", 15212],["Pittsburgh", 15237],["McCandless", 15090],["Shaler",15209],["Penn Hills",15235]].sample
      owner.city = city_zip[0]
      owner.state = "PA"
      owner.zip = city_zip[1]
      owner.phone = rand(10 ** 10).to_s.rjust(10,'0')
      owner.email = "#{owner.first_name.downcase}.#{owner.last_name.downcase}@example.com"
      # assume all the owners still have living pets and no one has moved out of town
      owner.active = true
      # set the timestamps
      owner.created_at = Time.now
      owner.updated_at = Time.now
      
      # Step 4A: add 1 to 3 pets for each owner
      Pet.populate 1..3 do |pet|
        pet.owner_id = owner.id
        # assign an animal id from ones created in Step 2
        pet.animal_id = Animal.all.map{|a| a.id}
        # randomly assign a pet name from list of typical pet names
        pet.name = %w[Sparky Dusty Caspian Lucky Fluffy Snuggles Snuffles Dakota Montana Cali Polo Buddy Mambo Pickles Pork\ Chop Fang Zaphod Yeller Groucho Meatball BJ CJ TJ Buttercup Bull Bojangles Copper Fozzie Nipper Mai\ Tai Bongo Bama Spot Tango Tongo Weeble]
        # randomly assign female status
        pet.female = [true, false]
        # pick a DOB at random ranging for 10 yrs ago to 6 months ago
        pet.date_of_birth = 120.months.ago.to_date..6.months.ago.to_date
        # assume all the pets are alive and active
        pet.active = true
        # set the timestamps
        pet.created_at = Time.now
        pet.updated_at = Time.now        
        
        # Step 4B: add between 1 to 15 visits for each pet
        Visit.populate 1..15 do |visit|
          visit.pet_id = pet.id
          # set the visit to sometime between DOB and the present
          visit.date = pet.date_of_birth..Date.today
          # different animals fall in different weight ranges so we need
          # to find the right range of weights for the visiting pet
          case pet.animal_id
          when 1  # birds tend to be between 1 & 2 pounds
            weight_range = (1..2) 
          when 2  # cats 
            weight_range = (5..15)
          when 3  # dogs
            weight_range = (10..60)
          when 4  # ferrets
            weight_range = (1..6)
          when 5  # rabbits
            weight_range = (2..7)
          end
          # now assign the pet a weight within the range
          visit.weight = weight_range
          # a couple of blurbing sentences for treatment notes
          visit.notes = Populator.sentences(2..10)
          # set the timestamps
          visit.created_at = Time.now
          visit.updated_at = Time.now
          
          # Step 4C: add some medicines to _some_ of the visits
          # Assume that approximately half of all visits includes a medicine
          get_med = rand(2)  # will generate numbers 0,1 at random
          if get_med.zero?   # time for medicine
            # first, figure out what meds this animal can get
            possible_medicines = AnimalMedicine.for_animal(pet.animal_id).map{|m| m.medicine_id}
            # assume that get either 1 or 2 meds per visit
            VisitMedicine.populate 1..2 do |vm|
              vm.visit_id = visit.id
              vm.medicine_id = possible_medicines
              vm.units_given = [100, 200, 300]
              if rand(20).zero? 
                vm.discount = 0.50
              else
                vm.discount = 0.00
              end
            end
          end
          
          # Step 4D: add some treatments given during the visit
          possible_procs = procedure_ids.shuffle
          # set the first treatment
          Treatment.populate 1 do |t1|
            t1.visit_id = visit.id
            t1.procedure_id = possible_procs.pop
            t1.successful = true
            t1.discount = 0.00
          end
          
          # set the second treatment if coin flip is heads...
          second_treatment = rand(1)
          if second_treatment.zero?
            Treatment.populate 1 do |t2|
              t2.visit_id = visit.id
              t2.procedure_id = possible_procs.pop
              t2.successful = true
              if rand(7).zero? 
                t2.discount = 0.25
              else
                t2.discount = 0.00
              end
            end
          end
          
          # set the third (or second) treatment in 25% of cases
          third_treatment = rand(3)
          if third_treatment.zero?
            Treatment.populate 1 do |t3|
              t3.visit_id = visit.id
              t3.procedure_id = possible_procs.pop
              t3.successful = true
              if rand(10).zero? 
                t3.discount = 0.50
              else
                t3.discount = 0.30
              end
            end
          end
          
          
        end
      end
    end
  end
end
