class ProductBacklogsController < ApplicationController
  Requirement = Struct.new(:id, :description, :size, :criteria_count, keyword_init: true)

  def show
    @requirements = [
      Requirement.new(id: 100, description: 'POとしてプロダクトゴールを設定したい', size: 5, criteria_count: 6),
      Requirement.new(id: 101, description: 'メンバーとしてプロダクトバックログアイテムを追加したい', size: 13, criteria_count: 0),
      Requirement.new(id: 102, description: 'DEVとしてをプロダクトバックログアイテムの大きさを設定したい', size: 8, criteria_count: 5),
    ]
  end
end
