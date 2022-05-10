require "administrate/base_dashboard"

class TotalResultDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    rank: Field::BelongsTo,
    user: Field::BelongsTo,
    recording_results: Field::HasMany,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  # 一覧画面に表示する属性
  COLLECTION_ATTRIBUTES = %i[
    id
    rank
    recording_results
    user
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  # 詳細画面に表示する属性
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    rank
    recording_results
    user
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  # 新規登録&編集画面に表示する属性
  FORM_ATTRIBUTES = %i[
    rank
    user
    recording_results
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how total results are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(total_result)
  #   "TotalResult ##{total_result.id}"
  # end
end
