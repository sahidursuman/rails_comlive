require 'rails_helper'

feature 'Updating a specification' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:commodity) { create(:commodity, app_id: app.id) }
  given!(:specification) { create(:specification, commodity_id: commodity.id ) }

  background do
    log_in(user)
    visit edit_app_commodity_specification_path(app, commodity, specification)
  end

  feature "Visiting #edit page" do
    scenario "should show the current specification's details" do
      uom_value = uom(specification.property).select{|u| u[1] == specification.uom }.flatten[0]

      expect(page).to have_text("Edit Specification")
      expect(page).to have_select('specification[property]', selected: specification.property)
      expect(find_field('specification[value]').value).to eq specification.value.to_s
      expect(page).to have_select('specification[uom]', selected: uom_value)
    end

    feature "with valid details" do
      scenario "user should be able to update the specification", js: true do
        property = properties.sample
        unit_of_measure = uom(property).sample

        select property, from: "specification[property]"
        fill_in "specification[value]", with: "30.87"
        select unit_of_measure[0], from: "specification[uom]"

        click_button "Update Specification"

        expect(page).to have_text("Specification updated successfully")
        expect(page).to have_text("#{property}: 30.87#{unit_of_measure[1]}")
      end
    end

    feature "with invalid details" do
      scenario "user should not be able to update the specification" do
        fill_in "specification[value]", with: ""
        click_button "Update Specification"

        expect(page).to have_text("Edit Specification")
        expect(page).to have_text("Value can't be blank")
      end
    end
  end
end

def properties
  Unitwise::Atom.all.uniq.map {|x| "#{x.property}"}.uniq
end

def uom(property)
  uoms = Unitwise::Atom.all.select{|a|
    a.property == property
  }.map {|i| ["#{i.to_s(:names)} (#{i.to_s(:primary_code)})",i.to_s(:primary_code)] }
  custom_units = CustomUnit.where(property: property)
  uoms += custom_units.map{|u| ["#{u.property} (#{u.uom})", u.uom] } if custom_units.any?
  return uoms
end