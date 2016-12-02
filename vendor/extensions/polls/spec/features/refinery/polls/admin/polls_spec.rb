# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Polls" do
    describe "Admin" do
      describe "polls", type: :feature do
        refinery_login

        describe "polls list" do
          before do
            FactoryGirl.create(:poll, :slug => "UniqueTitleOne")
            FactoryGirl.create(:poll, :slug => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.polls_admin_polls_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.polls_admin_polls_path

            click_link "Add New Poll"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Slug", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Polls::Poll, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Polls::Poll, :count)

              expect(page).to have_content("Slug can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:poll, :slug => "UniqueTitle") }

            it "should fail" do
              visit refinery.polls_admin_polls_path

              click_link "Add New Poll"

              fill_in "Slug", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Polls::Poll, :count)

              expect(page).to have_content("There were problems")
            end
          end

          context "with translations" do
            before do
              Refinery::I18n.stub(:frontend_locales).and_return([:en, :cs])
            end

            describe "add a page with title for default locale" do
              before do
                visit refinery.polls_admin_polls_path
                click_link "Add New Poll"
                fill_in "Slug", :with => "First column"
                click_button "Save"
              end

              it "should succeed" do
                expect(Refinery::Polls::Poll.count).to eq(1)
              end

              it "should show locale marker for page" do
                p = Refinery::Polls::Poll.last
                within "#poll_#{p.id}" do
                  expect(page).to have_css(".locale_marker", content: 'EN')
                end
              end

              it "should show slug in the admin menu" do
                p = Refinery::Polls::Poll.last
                within "#poll_#{p.id}" do
                  expect(page).to have_content('First column')
                end
              end
            end

            describe "add a poll with title for primary and secondary locale" do
              before do
                visit refinery.polls_admin_polls_path
                click_link "Add New Poll"
                fill_in "Slug", :with => "First column"
                click_button "Save"

                visit refinery.polls_admin_polls_path
                within ".actions" do
                  click_link "Edit this poll"
                end
                within "#switch_locale_picker" do
                  click_link "Cs"
                end
                fill_in "Slug", :with => "First translated column"
                click_button "Save"
              end

              it "should succeed" do
                expect(Refinery::Polls::Poll.count).to eq(1)
                expect(Refinery::Polls::Poll::Translation.count).to eq(2)
              end

              it "should show locale flag for page" do
                p = Refinery::Polls::Poll.last
                within "#poll_#{p.id}" do
                  expect(page).to have_css(".locale_marker", content: 'EN')
                  expect(page).to have_css(".locale_marker", content: 'CS')
                end
              end

              it "should show slug in backend locale in the admin menu" do
                p = Refinery::Polls::Poll.last
                within "#poll_#{p.id}" do
                  expect(page).to have_content('First column')
                end
              end
            end

            describe "add a slug with title only for secondary locale" do
              before do
                visit refinery.polls_admin_polls_path
                click_link "Add New Poll"
                within "#switch_locale_picker" do
                  click_link "Cs"
                end

                fill_in "Slug", :with => "First translated column"
                click_button "Save"
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Polls::Poll.last
                within "#poll_#{p.id}" do
                  expect(page).to have_content('First translated column')
                end
              end

              it "should show locale flag for page" do
                p = Refinery::Polls::Poll.last
                within "#poll_#{p.id}" do
                  expect(page).to have_css(".locale_marker", content: 'CS')
                end
              end
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:poll, :slug => "A slug") }

          it "should succeed" do
            visit refinery.polls_admin_polls_path

            within ".actions" do
              click_link "Edit this poll"
            end

            fill_in "Slug", :with => "A different slug"
            click_button "Save"

            expect(page).to have_content("'A different slug' was successfully updated.")
            expect(page).not_to have_content("A slug")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:poll, :slug => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.polls_admin_polls_path

            click_link "Remove this poll forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Polls::Poll.count).to eq(0)
          end
        end

      end
    end
  end
end
