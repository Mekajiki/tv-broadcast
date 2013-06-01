class ProgramFilter
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :keyword

  def initialize(options)
    @keyword = options.try(:[], :keyword)
  end

  def exec
    Program.where(['title like ? or detail like ? or extdetail like ? or category like ?'] +
                  ['%' + @keyword.to_s + '%'] * 4)
  end
end
