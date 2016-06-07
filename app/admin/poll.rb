ActiveAdmin.register Poll do
  config.filters = false
  permit_params :heading, :teaser, :description_heading, :description, :expires_at, vote_options_attributes: [ :id, :text, :_destroy ]


  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs # builds an input field for every attribute

    f.inputs "Vote options" do
      f.has_many :vote_options, allow_destroy: true, heading: 'test' do |vote_form|
        vote_form.input :text
      end
    end

    f.actions
  end

  show do
    attributes_table *Poll.column_names.map(&:to_sym)

    panel "Vote options" do
      table_for poll.vote_options do
        column :text
      end
    end

  end
end

