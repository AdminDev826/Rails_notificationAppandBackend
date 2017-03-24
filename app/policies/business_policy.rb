class BusinessPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user == record
  end

  def new?
    user == record
  end

  def home?
     user == record
  end

  def dashboard?
    if user.admin
      true
    elsif user.supervisor
      user == record.manager || user == record
    else
      user == record
    end
  end

  def supervisor_dashboard?
    user == record
  end

  def profile?
    if user.admin
      true
    elsif user.supervisor
      user == record.manager || user == record
    else
      user == record
    end
  end
end
