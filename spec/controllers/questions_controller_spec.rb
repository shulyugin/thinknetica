require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_pair(:question) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:answers) { create_list(:answer, 2, question: question) }

    before { get :show, params: { id: question } }

    it 'assigns the requested Question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'populates an array of all answers to question' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user

    before { get :edit, params: { id: question } }

    it 'assigns the requested Question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect do
          post :create, params: { question: attributes_for(:question) }
        end.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect do
          post :create, params: { question: attributes_for(:invalid_question) }
        end.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'with valid attributes' do
      it 'assigns the requested Question to @question' do
        patch :update,
              params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update,
              params: { id: question, question: attributes_for(:new_question) }

        question.reload

        expect(question.title).to eq attributes_for(:new_question)[:title]
        expect(question.body).to eq attributes_for(:new_question)[:body]
      end

      it 'redirects to the updated question' do
        patch :update,
              params: { id: question, question: attributes_for(:question) }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update,
              params: { id: question, question: { title: nil, body: nil } }
      end

      it 'does not change question attributes' do
        question.reload

        expect(question.title).to eq attributes_for(:question)[:title]
        expect(question.body).to eq attributes_for(:question)[:body]
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    before { question }

    it 'deletes question' do
      expect do
        delete :destroy, params: { id: question }
      end.to change(Question, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
