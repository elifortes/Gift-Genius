class Gift < ApplicationRecord
  enum occasion: [:Anniversary, :Baby_Shower, :Birthday, :Christmas, :Easter,
                    :Eid, :Engagement, :Father_s_Day, :Graduation, :Halloween,
                    :Housewarming, :Mother_s_Day, :New_Home, :New_Year_s_Eve,
                    :Retirement, :Thanksgiving, :Valentine_s_Day, :Wedding]
  # belongs_to :occasion

  has_one_attached :photo
end
