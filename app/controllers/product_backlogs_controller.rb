class ProductBacklogsController < ApplicationController
  def show
    @items = [
      OpenStruct.new(id: 100, description: 'POとしてプロダクトゴールを設定したい', size: 5, criteria_count: 6),
      OpenStruct.new(id: 101, description: 'メンバーとしてプロダクトバックログアイテムを追加したい', size: 5, criteria_count: 0),
      OpenStruct.new(id: 102, description: 'DEVとしてをプロダクトバックログアイテムの大きさを設定したい', size: 3, criteria_count: 5),
    ]
  end
end
