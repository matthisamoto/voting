require 'test_helper'

class DirectiveTest < ActiveSupport::TestCase
  context "A Directive instance" do
    
    should_validate_presence_of :phone_number

    context "if a stop instruction has been issued" do
      setup do
        Directive.create :phone_number => "9194497859", :message => "stop"
      end

      should "not allow voting" do
        assert !Directive.can_vote?
      end
    end

    context "if a start instruction has been issued within the last 15 minutes" do
      setup do
        Directive.create :phone_number => "9194497859", :message => "start"
      end

      should "allow voting" do
        assert Directive.can_vote?
      end
    end

    context "if a start instruction has been issued more than 15 minutes ago" do
      setup do
        d = Directive.create :phone_number => "9194497859", :message => "start"
        d.created_at = Time.now - 20.minutes
        d.save
      end

      should "not allow voting" do
        assert !Directive.can_vote?
      end
    end
  end
end
