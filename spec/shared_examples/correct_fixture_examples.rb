shared_examples 'correct fixture examples' do
  subject.call.each do |method_name, context_names|
    context "##{method_name}" do
      context_names.each do |context_name, tests|
        options = tests.delete("options") || {}
        name = context_name + (options.any? && " (#{options.inspect})" || "")
        context name do
          tests.each do |input, expectation|
            context input do
              subject { input.send method_name, options }
              it { should == expectation }
            end
          end
        end
      end
    end
  end
end
