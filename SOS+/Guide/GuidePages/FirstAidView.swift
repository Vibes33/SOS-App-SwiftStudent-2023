import SwiftUI

struct FirstAidView: View {
    @State private var selectedStep: Int? = nil
    @State private var selectedSituation: Int? = nil

    let steps = [
        ("Securing the place and the people", "shield.fill", Color.red),
        ("Assessment of the victim's condition", "person.fill.questionmark", Color.green),
        ("Request for assistance", "phone.fill.arrow.up.right", Color.blue),
        ("Realisation of first aid gestures", "bandage.fill", Color.orange)
    ]

    let situations = [
        ("Bleeding", "drop.fill", Color.red),
        ("Cooling", "waveform.path.ecg.rectangle.fill", Color.green),
        ("Unconsciousness", "person.fill.viewfinder", Color.blue)
    ]

    let stepSubtitles = [
        "Be careful not to put yourself in danger by approaching the accident site, after checking the safety conditions and potential additional risks (traffic, fire, electricity, etc.)\nIf you cannot act without taking risks, alert the emergency services, then establish a safety perimeter around the accident, while waiting for their arrival.",
        "To reassure the victim, introduce yourself to the victim and check that he or she is conscious and able to breathe. This information is essential and must be transmitted to the emergency services as soon as possible.",
        "It is essential to ask for help to the competent services, for that, numbers are listed in the category 'call' of SOS+, the emergency questionnaire is there if you do not know which service to contact.",
        "You can start giving first aid if you think it is necessary or if the competent services have asked you to do so, they will help the victim while waiting for help to arrive, examples of situations and how to react are present just below."
    ]

    let situationSubheadlines = [
        "Avoid, if possible, any contact with the victim's blood: ask him to compress the wound himself,\nOtherwise, apply pressure directly on the wound with your protected hands (disposable gloves, plastic bag or cloth),\nLay the victim down in a horizontal position,\nAsk someone to call for help or do it yourself if you are alone,\nif the wound continues to bleed, compress it even more firmly.\ncontinue to compress the wound until help arrives,\nif you need to get away (for example, to go to the hospital to report an emergency), apply a relay pad to replace your manual compression,\nwash your hands after performing this first aid.",
        "The victim cannot respond (possibly shaking his head), but is conscious.\nThe victim cannot speak, breathe or cough. The victim may hiss or try to cough without making a sound.\nSlap the victim on the back a maximum of 5 times. After each slap, check to see if everything is okay.\nIf the back slaps do not help, give up to 5 abdominal compressions.\nIf the problem is still not resolved, alternate 5 back slaps and 5 abdominal compressions.\nIf the victim becomes unconscious, gently place the victim on the ground and immediately alert emergency responders, then begin CPR by performing 30 chest compressions\nContinue CPR until help arrives or the victim resumes normal breathing.",
        "Check for unresponsive victim.\nClear the airway.\nCheck that the victim is breathing.\nTurn the victim onto his or her side in the recovery position.\nAsk someone to call for help; go for help if you are alone.\nCheck the victim's breathing regularly until help arrives."
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Text("First Aid")
                        .font(.largeTitle)
                        .fontWeight(.bold)


                    Divider()

                    Text("The Steps")
                        .font(.title2)
                        .fontWeight(.bold)

                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(0..<steps.count, id: \.self) { index in
                            Button(action: {
                                selectedStep = (selectedStep == index) ? nil : index
                            }) {
                                HStack {
                                    Image(systemName: steps[index].1)
                                        .font(.system(size: 23))
                                        .foregroundColor(steps[index].2)
                                    Text(steps[index].0)
                                    Spacer()
                                    if selectedStep == index {
                                        Image(systemName: "chevron.down")
                                    } else {
                                        Image(systemName: "chevron.right")
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                            if selectedStep == index {
                                Text(stepSubtitles[index])
                                    .padding(.leading)
                                    .transition(.move(edge: .top))
                            }
                        }
                    }

                    Divider()

                    Text("Common situations")
                        .font(.title2)
                        .fontWeight(.bold)

                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(0..<situations.count, id: \.self) { index in
                            Button(action: {
                                selectedSituation = (selectedSituation == index) ? nil : index
                            }) {
                                HStack {
                                    Image(systemName: situations[index].1)
                                        .font(.system(size: 23))
                                        .foregroundColor(situations[index].2)
                                    Text(situations[index].0)
                                    Spacer()
                                    if selectedSituation == index {
                                        Image(systemName: "chevron.down")
                                    } else {
                                        Image(systemName: "chevron.right")
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                            if selectedSituation == index {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("The steps of the intervention")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text(situationSubheadlines[index])
                                        .font(.subheadline)
                                }
                                .padding(.leading)
                                .transition(.move(edge: .top))
                            }
                        }
                    }
                    
                    
                    Divider()
                    
                    Text ("This guide is a general guide with predefined situations, the best thing to do in case of emergency is to contact competent services                                                                                                 ")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                    
                    Divider()
                    
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    struct FirstAidView_Previews: PreviewProvider {
        static var previews: some View {
            FirstAidView()
        }
    }
    }
