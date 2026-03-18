class PrefillCategoriesAndSubcategories < ActiveRecord::Migration[8.1]
  def change
    # require 'csv'
    # csv = CSV.generate do |csv|
    #   ItemCategory.find_each do |s| 
    #     csv << [s.classification, s.name, s.value, s.weight_kg]
    #   end
    # end
    category_data = <<~EOS
      supply,Apparel,1.0,10.0
      supply,Bedding,1.0,10.0
      supply,Cardiology,1.0,2.0
      supply,Dialysis,1.0,5.0
      supply,Dental,1.0,0.0
      supply,Drapes,1.0,10.0
      supply,Dressings,1.0,10.0
      supply,Ear Nose Throat,1.0,2.0
      supply,Fluids,1.0,2.0
      supply,Gastro Intestinal,1.0,2.0
      supply,Gloves,1.0,10.0
      supply,Gowns,1.0,15.0
      supply,IV,1.0,5.0
      supply,Lab,1.0,5.0
      supply,Masks,1.0,10.0
      supply,Needles-Syringes,1.0,2.0
      supply,OBS-GYN,1.0,2.0
      supply,OR - Surgery,1.0,2.0
      supply,Optometry,1.0,2.0
      supply,Orthopediacs,1.0,1.0
      supply,Patient-Care,1.0,2.0
      supply,Pediatric,1.0,5.0
      supply,Respiratory,1.0,5.0
      supply,Urology,1.0,5.0
      supply,Miscellaneous Supplies,1.0,5.0
      equipment,Medical_Bed,10.0,200.0
      equipment,Cane,1.0,0.2
      equipment,Commode,1.0,12.0
      equipment,Crutches,1.0,0.8
      equipment,Exam_Table,10.0,150.0
      equipment,Gurney,5.0,100.0
      equipment,IV-Pole,2.0,6.0
      equipment,Scale,2.0,12.0
      equipment,Walker,1.0,3.0
      equipment,Wheelchair,5.0,15.0
      equipment,Medicine_Cart,5.0,15.0
      equipment,Physio-Table,5.0,20.0
      equipment,Bath Seat,1.0,4.0
      equipment,Medical_Chair,5.0,30.0
      equipment,OR-Equipment,5.0,50.0
      equipment,Blood_Pressure_Monitor,2.0,10.0
      equipment,Pediatric Equip.,5.0,5.0
      equipment,Dental,2.0,1.0
      equipment,"Lifts, Patient",5.0,10.0
      equipment,Miscellaneous Equipment,1.0,2.0
      equipment,Respiratory Equip.,5.0,10.0
      equipment,Diagnostic,5.0,2.0
      equipment,Bedside Cabinet,2.0,30.0
      equipment,Linen Rack,2.0,15.0
      equipment,Overbed Table,2.0,10.0
      equipment,Procedure Light,1.0,5.0
      equipment,Service Trolly/Cart,1.0,8.0
      equipment,Sharps container,1.0,2.0
      equipment,Soiled Linen Cart,1.0,8.0
      equipment,Task Stool,1.0,8.0
      equipment,Storage Cabinet,5.0,30.0
    EOS

    CSV.new(category_data).each do |classification, category_name, weight_kg, value|
      ItemCategory.create!(
        classification: classification,
        name: category_name,
        weight_kg: weight_kg,
        value: value
      )
    end

    # require 'csv'
    # csv = CSV.generate do |csv|
    #   ItemSubcategory.find_each do |s| 
    #     csv << [s.name, s.item_category.classification, s.item_category.name, s.value, s.weight_kg]
    #   end
    # end
    subcategory_data = <<~EOS
      Mixed,supply,Apparel,,
      Uniforms,supply,Apparel,,
      Scrubs,supply,Apparel,,
      Patient Pajamas,supply,Apparel,,
      Aprons,supply,Apparel,,
      Gowns/disposable,supply,Apparel,,
      Gowns/cloth,supply,Apparel,,
      Lab Coats,supply,Apparel,,
      Fitted Sheets,supply,Bedding,,
      Soakers,supply,Bedding,,
      Flat Sheets,supply,Bedding,,
      Pillowcases,supply,Bedding,,
      Sliders,supply,Bedding,,
      Towels,supply,Bedding,,
      Mattress Cover,supply,Bedding,,
      Pillows,supply,Bedding,,
      Blankets,supply,Bedding,,
      Mixed,supply,Cardiology,,
      Mixed,supply,Dental,,
      Instruments,supply,Dental,,
      Mixed,supply,Drapes,,
      Table Covers,supply,Drapes,,
      Shoe Covers,supply,Drapes,,
      Laparotomy,supply,Drapes,,
      Vaginal Packs,supply,Drapes,,
      U-drapes,supply,Drapes,,
      Converters,supply,Drapes,,
      Thyroid,supply,Drapes,,
      Mayo Stand Covers,supply,Drapes,,
      Mixed,supply,Dressings,,
      Wound,supply,Dressings,,
      Diabetic,supply,Dressings,,
      Surgical,supply,Dressings,,
      Ulcer supplies,supply,Dressings,,
      Burns,supply,Dressings,,
      Coban,supply,Dressings,,
      Mixed,supply,Ear Nose Throat,,
      Irrigation,supply,Fluids,,
      Feeding Bags,supply,Gastro Intestinal,,
      Feeding Tubes,supply,Gastro Intestinal,,
      Surgical,supply,Gloves,,
      Exam,supply,Gloves,,
      Mixed,supply,Gowns,,
      Cloth,supply,Gowns,,
      Disposable,supply,Gowns,,
      Mixed,supply,IV,,
      Solution Sets,supply,IV,,
      Space pump,supply,IV,,
      Y-Type,supply,IV,,
      Adminstration Set,supply,IV,,
      Specimen Supplies,supply,Lab,,
      Blood Collection,supply,Lab,,
      GlassWare,supply,Lab,,
      Pipets,supply,Lab,,
      Petrie Dishes,supply,Lab,,
      with Face Shields,supply,Masks,,
      Surgical ,supply,Masks,,
      Procedure,supply,Masks,,
      Various Sizes,supply,Needles-Syringes,,
      Sharps Containers,supply,Needles-Syringes,,
      3ml,supply,Needles-Syringes,,
      10ml,supply,Needles-Syringes,,
      30ml,supply,Needles-Syringes,,
      50ml,supply,Needles-Syringes,,
      Mixed,supply,OBS-GYN,,
      Speculum,supply,OBS-GYN,,
      Anaesthesia Supplies,supply,OR - Surgery,,
      Endoscopy Supplies,supply,OR - Surgery,,
      PICC Kit,supply,OR - Surgery,,
      Trays - Sterilization,supply,OR - Surgery,,
      Instrument Trays,supply,OR - Surgery,,
      Wound Drainage,supply,OR - Surgery,,
      Ostomy,supply,OR - Surgery,,
      Mixed,supply,Optometry,,
      Knee Brace,supply,Orthopediacs,,
      Ankle Braces,supply,Orthopediacs,,
      Splints,supply,Orthopediacs,,
      Back Support,supply,Orthopediacs,,
      Boot,supply,Orthopediacs,,
      Orthotics,supply,Orthopediacs,,
      Mixed,supply,Patient-Care,,
      Slippers,supply,Patient-Care,,
      Incontinence supplies,supply,Patient-Care,,
      Mixed,supply,Pediatric,,
      Feeding Supplies,supply,Pediatric,,
      Izzy Dolls,supply,Pediatric,,
      Diapers,supply,Pediatric,,
      Mixed,supply,Respiratory,,
      Suction Tubing,supply,Respiratory,,
      Nasal Prongs,supply,Respiratory,,
      Masks,supply,Respiratory,,
      Tracheotomy,supply,Respiratory,,
      Nebulizer,supply,Respiratory,,
      Oxygen Therapy,supply,Respiratory,,
      Endotrachial,supply,Respiratory,,
      Suction Catheter,supply,Respiratory,,
      Suction tubing&catheter,supply,Respiratory,,
      Mixed,supply,Urology,,
      Irragation Trays,supply,Urology,,
      Foley Trays,supply,Urology,,
      Catheters,supply,Urology,,
      Leg Bags,supply,Urology,,
      Electric,equipment,Medical_Bed,,
      Manual,equipment,Medical_Bed,,
      Electric/Manual,equipment,Medical_Bed,,
      Birthing,equipment,Medical_Bed,,
      Fixed,equipment,Medical_Bed,,
      Stationary,equipment,Commode,,
      Wheeled,equipment,Commode,,
      Underarm,equipment,Crutches,,
      Forearm,equipment,Crutches,,
      Gutter,equipment,Crutches,,
      Bed,equipment,IV-Pole,,
      Adult Upright Beam ,equipment,Scale,2.0,16.0
      Adult Floor,equipment,Scale,1.0,5.0
      Pediatric,equipment,Scale,2.0,9.0
      4 Wheel,equipment,Walker,,
      2 Wheel,equipment,Walker,,
      Folding no wheels,equipment,Walker,,
      Fixed,equipment,Walker,,
      Folding,equipment,Wheelchair,,
      Rigid,equipment,Wheelchair,5.0,21.0
      Transport,equipment,Wheelchair,,
      Crash,equipment,Medicine_Cart,,
      Nursing,equipment,Medicine_Cart,,
      Medications,equipment,Medicine_Cart,,
      Other,equipment,Medicine_Cart,,
      Manual,equipment,Blood_Pressure_Monitor,1.0,1.0
      Electric,equipment,Blood_Pressure_Monitor,2.0,1.5
      Infant Warmer,equipment,Pediatric Equip.,10.0,85.0
      Chair,equipment,Dental,10.0,100.0
      Light,equipment,Dental,5.0,10.0
      X-Ray,equipment,Dental,,
      Standard,equipment,Cane,,
      Other,supply,Apparel,,
      Mixed,supply,Gloves,,
      Other,supply,Orthopediacs,,
      4 wheel,equipment,IV-Pole,,
      5 wheel,equipment,IV-Pole,,
      Quad,equipment,Cane,,
      Instruments,equipment,Dental,,
      Other,equipment,Dental,,
      Specialty,equipment,Cane,,
      Manual,equipment,Exam_Table,,
      Electric,equipment,Exam_Table,,
      Other,equipment,Miscellaneous Equipment,,
      Bassinet,equipment,Pediatric Equip.,2.0,33.0
      Crib,equipment,Pediatric Equip.,4.0,5.0
      O2 Concentrator,equipment,Respiratory Equip.,10.0,90.0
      Ventilator,equipment,Respiratory Equip.,10.0,50.0
      CPAP,equipment,Respiratory Equip.,5.0,5.0
      Bi-PAP,equipment,Respiratory Equip.,3.0,4.0
      Tank Carts,equipment,Respiratory Equip.,1.0,5.0
      Other,equipment,Respiratory Equip.,,
      Anesthesia,equipment,OR-Equipment,10.0,100.0
      Analgesic,equipment,OR-Equipment,2.0,10.0
      Instruments,equipment,OR-Equipment,2.0,5.0
      Other,equipment,OR-Equipment,2.0,5.0
      Vital Signs Monitors,equipment,Diagnostic,2.0,2.0
      Ultrasound,equipment,Diagnostic,10.0,170.0
      Scopes,equipment,Diagnostic,2.0,1.0
      Other,equipment,Diagnostic,1.0,1.0
      Other,supply,Miscellaneous Supplies,,
      Examination Table,equipment,Pediatric Equip.,2.0,20.0
      Manual,equipment,Physio-Table,2.0,20.0
      Electric,equipment,Physio-Table,5.0,20.0
      Manual,equipment,"Lifts, Patient",5.0,5.0
      Powered,equipment,"Lifts, Patient",5.0,5.0
      Other,supply,Dressings,,
      Mixed,supply,Bedding,,
      Other,supply,Bedding,,
      Other,supply,Dental,,
      Other,supply,Drapes,,
      Mixed,supply,Gastro Intestinal,,
      Other,supply,Gastro Intestinal,,
      Mixed,supply,Lab,,
      Other,supply,Lab,,
      N95,supply,Masks,,
      Mixed Sizes,supply,Needles-Syringes,,
      Other,supply,OBS-GYN,,
      Other,supply,OR - Surgery,,
      Other,supply,Patient-Care,,
      Mattress,equipment,Medical_Bed,5.0,27.0
      General,equipment,Bedside Cabinet,,
      General,equipment,Gurney,,
      General,equipment,Linen Rack,,
      General,equipment,Medical_Chair,,
      General,equipment,Overbed Table,,
      General,equipment,Procedure Light,,
      General,equipment,Soiled Linen Cart,,
      General,equipment,Service Trolly/Cart,,
      General,equipment,Sharps container,,
      General,equipment,Storage Cabinet,,
      General,equipment,Task Stool,,
      General,equipment,Bath Seat,,
      Trays,supply,Dressings,,
      Angio,supply,Cardiology,,
      Other,supply,Dialysis,,
      Hemodialysis,supply,Dialysis,,
      Peritoneal Dialysis,supply,Dialysis,,
      Mixed,supply,Masks,,
      Infusion Sets,supply,IV,,
      Transfusion Sets,supply,IV,,
      Droppers/Tubes,supply,Lab,,
      Vacutainer Tubes,supply,Lab,,
      Trays - Instrument,supply,OR - Surgery,,
      Respiratory,supply,OR - Surgery,,
      Laparoscopy,supply,OR - Surgery,,
      Orthopedic,supply,OR - Surgery,,
      Cautery,supply,OR - Surgery,,
      Casting,supply,Orthopediacs,,
      Collars,supply,Orthopediacs,,
      Compression,supply,Orthopediacs,,
      Bariatric,equipment,Medical_Bed,,200.0
    EOS

    CSV.new(subcategory_data).each do |name, category_classification, category_name, weight_kg, value|
      category = ItemCategory.find_by(name: category_name, classification: category_classification)
      ItemSubcategory.create!(
        name: name,
        item_category: category,
        weight_kg: weight_kg,
        value: value
      )
    end
  end
end
