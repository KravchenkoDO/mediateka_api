# frozen_string_literal: true

# This matcher will help us to create nice single-line test for our Pundit policies.
# Now We are able to make test like this:
# it { should_not authorize(:create)   }

RSpec::Matchers.define :authorize do |action|
  match do |policy|
    policy.public_send("#{action}?")
  end

  failure_message do |policy|
    "#{policy.class} does not permit #{action} on #{policy.record} for #{policy.user.inspect}."
  end

  failure_message_when_negated do |policy|
    "#{policy.class} does not forbid #{action} on #{policy.record} for #{policy.user.inspect}."
  end
end
