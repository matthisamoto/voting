require 'test_helper'

class DirectiveTest < ActiveSupport::TestCase
  context "A Directive instance" do
    context "if a stop instruction has been issued" do
      setup do
        Directive.create :message => "stop"
      end

      should "not allow voting" do
        assert !Directive.can_vote?
      end
    end

    context "if a start instruction has been issued within the last 15 minutes" do
      setup do
        Directive.create :message => "start"
      end

      should "allow voting" do
        assert Directive.can_vote?
      end
    end

    context "if a start instruction has been issued more than 15 minutes ago" do
      setup do
        d = Directive.create :message => "start"
        d.created_at = Time.now - 20.minutes
        d.save
      end

      should "not allow voting" do
        assert !Directive.can_vote?
      end
    end
  end
end
