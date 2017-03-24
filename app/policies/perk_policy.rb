class PerkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.supervisor
        scope.where(business: user.businesses)
      else
        scope.where(business: user)
      end
    end
  end

  def create?
    true
  end

  def edit?
    true
    # user.id == record.business_id || user.id == record.business.manager.id
  end

  def update?
    user.id == record.business_id
  end

  def destroy?
    user.id == record.business_id
  end
end
