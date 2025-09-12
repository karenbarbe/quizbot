# == Schema Information
#
# Table name: quizzes
#
#  id         :bigint           not null, primary key
#  score      :float
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Quiz < ApplicationRecord
end
