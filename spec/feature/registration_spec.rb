feature 'registration' do
  scenario 'a user can sign up' do
    visit '/register'
    fill_in('firstname', with: 'Dennis')
    fill_in('lastname', with: 'the Menace')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password123')
    click_button('Sign up')

    expect(page).to have_content "Thank you for registering with MakersBnB, Dennis"
  end
end