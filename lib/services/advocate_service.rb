class AdvocateService
  attr_accessor :output, :display

  def add_sr_advocate(code)
    adv = Advocate.find_or_create_by(code: code, position: Advocate::POSITIONS.first)
    @output = "Advocate added: #{adv.code}"
    @display = "Advocate Name: #{adv.code}"

    self
  end

  def add_jr_advocate(sr_code, jr_code)
    sr_adv = Advocate.find_by_code(sr_code)
    jr_adv = Advocate.find_or_create_by(
                        code: jr_code,
                        position: Advocate::POSITIONS.second,
                        senior_id: sr_adv.id
                      )

    @output = "Advocate added #{jr_adv.code} under #{sr_adv.code}"
    @display = "Advocate Name: #{sr_adv.code} \n Practicing states: TN \n - Advocate Name: #{jr_adv.code}"

    self
  end

  def add_practicing_state(adv_code, state_name)
    adv = Advocate.where(code: adv_code).first
    state = State.find_or_create_by(name: state_name)

    valid_state = adv.senior? ? true : adv.senior.states.pluck(:name).include?(state_name)

    if valid_state
      adv.advocate_states.find_or_create_by(state_id: state.id)
      @output = "State Added #{state_name} for #{adv_code}"
      @display = <<~HEREDOC
        Advocate Name: #{adv_code}
        Practicing states: #{adv.states.pluck(:name).join(", ")}
      HEREDOC
    else
      @output = "Cannot add #{state_name} for #{adv_code}"
    end

    if adv.junior?
      senior = adv.senior
      @display =  <<~HEREDOC
        Advocate Name: #{senior.code}
        Practicing States: #{senior.states.pluck(:name).join(", ")}
          - Advocate Name: #{adv.code}
          - Practicing States: #{adv.states.pluck(:name).join(", ")}"
      HEREDOC
    end

    self
  end

  def add_case(adv_code, case_code, state_name)
    adv = Advocate.where(code: adv_code).first
    state = State.find_or_create_by(name: state_name)
    kase = Case.find_or_create_by(case_code: case_code, state_id: state.id)

    valid_case = adv.senior? ? true : adv.valid_case_for_jr(case_code)

    if adv.states.include? kase.state.name && valid_case
      adv.advocate_cases.find_or_create_by(case_id: kase.id, status: 'accepted')
      @output = "Case #{case_code} added for #{adv_code}"
      @display = <<~HEREDOC
        Advocate Name: #{adv.code}
        Practicing states: #{adv.states.pluck(:name).join(', ')}
        Practicing Cases: #{adv.cases.pluck(:case_code).join(', ')}
      HEREDOC
    else
      @output = "Cannot add #{state_name} for #{case_code}"
    end

    if adv.junior?
      @display = <<~HEREDOC
        Advocate Name: #{adv.senior.code}
        Practicing states: #{adv.senior.states.pluck(:name).join(', ')}
        Practicing Cases: #{adv.cases.pluck(:case_code).join(', ')}
        - Advocate Name: #{adv.code}
        - Practicing states: #{adv.states.pluck(:name).join(', ')}
      HEREDOC
    end

    self
  end

  def reject_case(adv_code, case_code, state_name)
    adv = Advocate.where(code: adv_code).first
    state = State.find_or_create_by(name: state_name)
    kase = Case.find_or_create_by(case_code: case_code, state_id: state.id)

    if adv.senior?
      adv.advocate_cases.find_or_create_by(case_id: kase.id, status: 'accepted')
      @output = "Case #{case_code} is added to the Block list for #{adv_code}."
      @display = <<~HEREDOC
        Advocate Name: #{adv.code}
        Practicing states: #{adv.states.pluck(:name).join(', ')}
        Practicing Cases: #{adv.cases.map{|kase| 'kase.case_code kase.state.name'}}.join(', ')
        BlockList Cases: 66666-TN
        - Advocate Name: 101
        - -Practicing states: TN
      HEREDOC
    else
      @output = "Cannot add #{state_name} for #{case_code}"
    end

    self
  end

  def all_advocates
    @output = Advocate.all.pluck(:code).join(", ")
    @display = @output

    self
  end

  def case_under_state(state)
    advs = Advocate.joins([:cases, :states]).where("states.name = ?", state).group_by(&:code).map{|a, b| [a, b[0].cases.pluck(:case_code)] }.to_h

    @output = <<~HEREDOC
      #{state}:
      #{ advs.each { |key, value| puts "#{key}: #{value}" } }

    HEREDOC

    @display = @output

    self
  end
end
