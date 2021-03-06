require "spec_helper"
include ActionController::RecordIdentifier

describe Refinery do
  describe "Portfolio" do
    describe "Admin" do
      describe "Items" do
        login_refinery_user

        let(:image) { mock_model(Refinery::Image, :id => 23, :url => 'http://gifs.gifbin.com/1236681924_snail_transformers.gif') }
        let(:item) { FactoryGirl.create(:item, :gallery_id => nil, :image_id => 23) } 
        let(:gallery) { FactoryGirl.create(:gallery) }
        let(:galleried_item) { FactoryGirl.create(:item, :gallery_id => gallery.id, :image_id => 23) }

        describe "items list" do
          before(:each) do
            item.stub(:image).and_return(image)
          end

          context "no parent gallery" do
            it "shows items" do
              visit refinery.portfolio_admin_galleries_path
              within "#actions" do
                click_link "View top-level images"
              end

              page.should have_content item.title
            end
          end

          context "parent gallery" do
            before(:each) do
              # force load
              galleried_item
            end

            it "shows items" do
              visit refinery.portfolio_admin_galleries_path
              within("##{dom_id(gallery)}") do
                click_link '1 image'
              end
              page.should have_content(galleried_item.title)
            end
          end
        end

        describe "create" do
          context "valid data" do
            it "succeeds" do
              pending "Needs implementation"
              visit refinery.portfolio_admin_galleries_path
              within("#actions") do
                click_link 'Add an image'
              end

              fill_in :title, :with => "My Image"
              click_link "There is currently no image selected, please click here to add one."
            end
          end

          context "invalid data" do
            it "fails" do
            end
          end

          context "duplicate" do
            it "fails" do
            end
          end
        end

        describe "edit" do
          it "succeeds" do
          end
        end

        describe "destroy" do
          it "succeeds" do
          end
        end

      end
    end
  end
end
