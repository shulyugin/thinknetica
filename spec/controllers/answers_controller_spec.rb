require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:some_user) { create(:user) }

  describe 'GET #show' do
    before { sign_in answer.user }

    before { get :show, params: { id: answer } }

    it 'assigns the requested Answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { sign_in answer.user }

    before { get :new, params: { question_id: question } }

    it 'assigns the requested Question to @question' do
      expect(assigns(:answer).question).to eq question
    end

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { sign_in answer.user }

    before { get :edit, params: { id: answer } }

    it 'assigns the requested Answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before { sign_in answer.user }

    context 'with valid attributes' do
      let(:create_valid_answer) do
        post :create,
             params: {
               answer: attributes_for(:answer),
               question_id: question
             }
      end

      it 'assigns the requested Question to @question' do
        create_valid_answer
        expect(assigns(:answer).question).to eq question
      end

      it 'saves the new answer in the database' do
        expect { create_valid_answer }.to change(question.answers, :count).by(1)
      end

      it 'redirects to show view' do
        create_valid_answer
        expect(response).to redirect_to question_path(assigns(:answer).question)
      end
    end

    context 'with invalid attributes' do
      let(:create_invalid_answer) do
        post :create,
             params: {
               answer: attributes_for(:invalid_answer),
               question_id: question
             }
      end

      it 'does not save the answer' do
        expect { create_invalid_answer }.not_to change(question.answers, :count)
      end

      it 're-renders new view' do
        create_invalid_answer
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { sign_in answer.user }

    context 'with valid attributes' do
      it 'assigns the requested Answer to @answer' do
        patch :update,
              params: { id: answer, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer body' do
        new_body = attributes_for(:new_answer)[:body]

        patch :update,
              params: { id: answer, answer: { body: new_body } }

        answer.reload

        expect(answer.body).to eq new_body
      end

      it 'redirects to the updated answer' do
        patch :update,
              params: { id: answer, answer: attributes_for(:new_answer) }
        expect(response).to redirect_to answer
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update,
              params: { id: answer, answer: { body: nil, question_id: nil } }
      end

      it 'doesnt change answer question_id' do
        answer.reload
        expect(answer.question).to eq assigns(:answer).question
      end

      it 'does not change answer body' do
        answer.reload
        expect(answer.body).to eq attributes_for(:answer)[:body]
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end

    describe 'DELETE #destroy' do
      before { sign_in answer.user }

      before { answer }

      it 'author deletes his answer' do
        expect do
          delete :destroy, params: { id: answer }
        end.to change(question.answers, :count).by(-1)
      end

      it 'redirects to question view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(assigns(:answer).question)
      end

      it 'not an author fails to delete someone\'s answer' do
        sign_in some_user
        expect do
          delete :destroy, params: { id: answer }
        end.to change(question.answers, :count).by(0)
      end
    end
  end
end
