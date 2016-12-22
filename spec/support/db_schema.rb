ActiveRecord::Schema.define(version: 20161122225732) do
  create_table "test_uuids", force: true do |t|
    t.datetime "released_at"
    t.string   "name"
    t.uuid     "uuid"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "flag"
  end
end
