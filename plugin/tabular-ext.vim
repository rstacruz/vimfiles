if exists('g:tabular_loaded')

  " For commas (like has has_many :x, though: x)
  "
  "   belongs_to :last_project,  class_name: 'Project'
  "   has_many :assignments,     dependent: :destroy
  "   has_many :projects,        through: :assignments
  "   validates :name,           presence: true
  "
  AddTabularPattern! commas /,\zs/l1l0

  " Variables
  "
  "   var x     = 2;
  "   var oaetu = 3;
  "
  AddTabularPattern! equals /[=:]/

  " For CSS patterns
  "
  "   position: absolute
  "   left:     4px
  "   top:      5px
  "
  AddTabularPattern! css /: \zs/l1l0

  AddTabularPattern! rubysymbols /:\zs/l1l0

endif
