ActiveAdmin.register Poll do
  config.filters = false
  permit_params :category_id, :image, :background_image, :wallpaper, :sub_heading, :order, :heading, :question, :teaser, :description_heading, :description, :expires_at, vote_options_attributes: [:id, :text, :_destroy]

  index do
    column :heading
    column :teaser
    column :category do |x|
      x.category.name
    end
    column :order
    column :updated_at
    column :created_at
    column :expires_at
    actions
  end


  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs :category, :heading, :question,:sub_heading, :teaser, :description_heading, :description, :order, :expires_at

    f.inputs "Images" do
      f.input :image, as: :file, hint: image_tag(f.object.image.url(:medium))
      #f.input :image_cache, as: :hidden
      f.input :background_image, as: :file, hint: image_tag(f.object.background_image.url(:medium))
      #f.input :background_image_cache, as: :hidden
      f.input :wallpaper, as: :file, hint: image_tag(f.object.wallpaper.url(:big), style: 'width:20%')
    end

    f.inputs "Vote options" do
      f.has_many :vote_options, allow_destroy: true, heading: 'test' do |vote_form|
        vote_form.input :text
      end
    end

    f.actions
  end

  show do
    attributes_table :category, :heading, :sub_heading, :question,:teaser, :description_heading, :description, :order, :expires_at

    panel "Images" do
      attributes_table_for resource do
        row :image do
          image_tag resource.image.url(:medium)
        end
        row :background_image do
          image_tag resource.background_image.url(:medium)
        end
        row :wallpaper do
          image_tag resource.wallpaper.url(:big), style: 'width:20%'
        end
      end
    end

    panel "Vote options" do
      table_for poll.vote_options do
        column :text
      end
    end
  end

  controller do
    def scoped_collection
      super.includes :category
    end
  end
end

