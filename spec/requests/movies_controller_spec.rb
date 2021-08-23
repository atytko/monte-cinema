# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_controllers'

RSpec.describe MoviesController, type: :request do
  let(:role) { create(:user_role) }
  let(:user) { create(:user, user_role: role) }

  describe '#index' do
    subject(:get_movies) { get '/movies' }

    let(:movie) { create(:movie) }

    it 'returns 200 http status' do
      get_movies
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    subject(:get_movie) { get "/movies/#{movie.id}" }

    let(:movie) { create(:movie) }
    let(:expected_response) do
      {
        'data' => {
          'id' => movie.id.to_s,
          'type' => 'movie',
          'attributes' => {
            'title' => movie.title,
            'description' => movie.description,
            'genre' => movie.genre,
            'duration' => movie.duration,
            'director' => movie.director
          },
          'relationships' => {
            'screenings' => {
              'data' => []
            }
          }
        }
      }
    end

    it 'returns 200 http status' do
      get_movie
      expect(response).to have_http_status(:ok)
    end

    it 'works and returns a valid response' do
      get_movie
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end

  describe '#create' do
    subject(:create_movie) do
      post '/movies',
           params: { movie: { title: 'Titanic', genre: 'drama', director: 'James Cameron', description: 'lorem ipsum',
                              duration: 195 } }
    end

    context 'when the user is logged in' do
      let(:role) { create(:user_role, name: 'employee') }
      let(:role) { create(:user_role, name: 'manager') }

      sign_in :user

      it 'returns 201 http status' do
        create_movie
        expect(response).to have_http_status(:created)
      end

      it 'works and the count is changed properly' do
        expect { create_movie }.to change(Movie, :count).by(1)
      end

      it 'does not allow to create a movie with missing params' do
        expect { post '/movies', params: {} }
          .to raise_error(ActionController::ParameterMissing)
      end
    end

    include_examples 'unauthorized'

    context 'when user is not employee or manager' do
      sign_in :user

      it 'returns 403 http status' do
        create_movie
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe '#update' do
    subject(:update_movie) do
      patch "/movies/#{movie.id}",
            params: { movie: { title: 'Titanic', genre: 'drama', director: 'James Cameron', description: 'lorem ipsum',
                               duration: 195 } }
    end

    let(:movie) { create(:movie) }

    context 'when the user is logged in' do
      let(:role) { create(:user_role, name: 'employee') }
      let(:role) { create(:user_role, name: 'manager') }

      sign_in :user

      it 'returns 200 http status' do
        update_movie
        expect(response).to have_http_status(:ok)
      end
    end

    include_examples 'unauthorized'
  end

  describe '#destroy' do
    subject(:delete_movie) { delete "/movies/#{movie.id}" }

    let!(:movie) { create(:movie) }

    context 'when the user is logged in' do
      let(:role) { create(:user_role, name: 'employee') }
      let(:role) { create(:user_role, name: 'manager') }

      sign_in :user

      it 'returns 204 http status' do
        delete_movie
        expect(response).to have_http_status(:no_content)
      end

      it 'works and the count is changed properly' do
        expect { delete_movie }.to change(Movie, :count).by(-1)
      end
    end

    include_examples 'unauthorized'
  end
end
