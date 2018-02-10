require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_calendar) { create(:calendar, user: my_user) }
  let(:other_user) { create(:user) }

  context "guest user" do
    describe "GET index" do
      it "returns http success" do
        get :index, params: { user_id: my_user.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { user_id: my_user.id, id: my_calendar.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { user_id: my_user.id, id: my_calendar.id }
        expect(response).to render_template :show
      end

      it "assigns my_calendar to @calendar" do
        get :show, params: { user_id: my_user.id, id: my_calendar.id }
        expect(assigns(:calendar)).to eq(my_calendar)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new, params: { user_id: my_user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, user_id: my_user.id, calendar: {title: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, user_id: my_user.id, id: my_calendar.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, user_id: my_user.id, id: my_calendar.id, calendar: {title: new_title, description: new_description}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, user_id: my_user.id, id: my_calendar.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "user doing CRUD on a calendar they don't own" do
    before do
      create_session(other_user)
    end

    describe "GET index" do
      it "returns http success" do
        get :index, user_id: my_user.id
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, user_id: my_user.id, id: my_calendar.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, user_id: my_user.id, id: my_calendar.id
        expect(response).to render_template :show
      end

      it "assigns my_calendar to @calendar" do
        get :show, user_id: my_user.id, id: my_calendar.id
        expect(assigns(:calendar)).to eq(my_calendar)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new, user_id: my_user.id
        expect(response).to redirect_to([my_user, my_calendar])
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, user_id: my_user.id, calendar: {title: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to([my_user, my_calendar])
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, user_id: my_user.id, id: my_calendar.id
        expect(response).to redirect_to([my_user, my_calendar])
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, user_id: my_user.id, id: my_calendar.id, calendar: {title: new_title, description: new_description}
        expect(response).to redirect_to([my_user, my_calendar])
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, user_id: my_user.id, id: my_calendar.id
        expect(response).to redirect_to([my_user, my_calendar])
      end
    end
  end

  context "user doing CRUD on a calendar they own" do
    before do
      create_session(my_user)
    end

    describe "GET index" do
      it "returns http success" do
        get :index, user_id: my_user.id
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, user_id: my_user.id, id: my_calendar.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, user_id: my_user.id, id: my_calendar.id
        expect(response).to render_template :show
      end

      it "assigns my_calendar to @calendar" do
        get :show, user_id: my_user.id, id: my_calendar.id
        expect(assigns(:calendar)).to eq(my_calendar)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, user_id: my_user.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, user_id: my_user.id
        expect(response).to render_template :new
      end

      it "instantiates @calender" do
        get :new, user_id: my_user.id
        expect(assigns(:calendar)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Calendar by 1" do
        expect{post :create, user_id: my_user.id, calendar: {title: RandomData.random_sentence, description: RandomData.random_paragraph} }.to change(Calendar,:count).by(1)
      end

      it "assigns the new calendar to @calendar" do
        post :create, user_id: my_user.id, calendar: {title: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(assigns(:calendar)).to eq Calendar.last
      end

      it "redirects to the new calendar" do
        post :create, user_id: my_user.id, calendar: {title: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to [my_user, Calendar.last]
      end
    end

    describe "GET edit" do
      it "rreturns http success" do
        get :edit, user_id: my_user.id, id: my_calendar.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, user_id: my_user.id, id: my_calendar.id
        expect(response).to render_template :edit
      end

      it "assigns calendar to be updated to @calendar" do
        get :edit, user_id: my_user.id, id: my_calendar.id
        calendar_instance = assigns(:calendar)

        expect(calendar_instance.id).to eq my_calendar.id
        expect(calendar_instance.title).to eq my_calendar.title
        expect(calendar_instance.description).to eq my_calendar.description
      end
    end

    describe "PUT update" do
      it "updates calendar with expected attributes" do
        new_title = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, user_id: my_user.id, id: my_calendar.id, calendar: {title: new_title, description: new_description}

        updated_calendar = assigns(:calendar)
        expect(updated_calendar.id).to eq my_calendar.id
        expect(updated_calendar.title).to eq new_title
        expect(updated_calendar.description).to eq new_description
      end

      it "redirects to the updated calendar" do
        new_title = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, user_id: my_user.id, id: my_calendar.id, calendar: {title: new_title, description: new_description}
        expect(response).to redirect_to [my_user, my_calendar]
      end
    end

    describe "DELETE destroy" do
      it "deletes the calendar" do
        delete :destroy, user_id: my_user.id, id: my_calendar.id
        count = Calendar.where({id: my_calendar.id}).size
        expect(count).to eq 0
      end

      it "redirects to calendars index" do
        delete :destroy, user_id: my_user.id, id: my_calendar.id
        expect(response).to redirect_to my_user
      end
    end
  end
end
