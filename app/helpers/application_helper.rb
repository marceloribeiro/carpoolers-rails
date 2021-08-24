# frozen_string_literal: true

module ApplicationHelper
  def card(title, content)
    render('shared/card', title: title, content: content)
  end

  def owns?(carpool)
    carpool.user == current_user
  end

  def joined?(carpool)
    current_user.joined_carpool?(carpool)
  end

  def approved?(carpool)
    current_user.approved_for_carpool?(carpool)
  end
end
