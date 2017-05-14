module ApplicationHelper
  def sections
    [:profiles]
  end

  def format_user(um)
    um.fullname || um.email
  end
end
