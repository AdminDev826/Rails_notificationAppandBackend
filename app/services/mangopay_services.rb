class MangopayServices

  def initialize(current_user)
      @user = current_user
  end

  def create_mangopay_natural_user
    user_info = {
      "FirstName": @user.first_name,
      "LastName": @user.last_name,
      "Birthday": @user.birthday.to_i,
      "Nationality": "FR",
      # "Nationality": self.nationality,
      "CountryOfResidence": "FR",
      "PersonType": "NATURAL",
      "Email": @user.email
    }

    mangopay_user = mangopay_natural_user_create(user_info)
  end

  def create_mangopay_card_pre_registration
    card_registration_info = {
      UserId: @user.mangopay_id,
      Currency: "EUR",
      CardType: "CB_VISA_MASTERCARD"
    }

    mangopay_card_registration_create(card_registration_info)
  end

  def create_mangopay_payin(wallet_id)

    if @user.subscription == "M"
      if @user.amount <= 5
        percent_asso = ((50-30)*((@user.amount-1)/(5.0-1.0)))+30
      elsif @user.amount <= 10
        percent_asso = ((70-50)*((@user.amount-5)/(10.0-5.0)))+50
      elsif @user.amount <= 15
        percent_asso = ((75-70)*((@user.amount-10)/(15.0-10.0)))+70
      elsif @user.amount <= 20
        percent_asso = ((77.5-75)*((@user.amount-15)/(20.0-15.0)))+75
      elsif @user.amount <= 25
        percent_asso = ((80-77.5)*((@user.amount-20)/(25.0-20.0)))+77.5
      elsif @user.amount <= 50
        percent_asso = (((85-80)*((@user.amount-25)/(50.0-25.0)))+80)
      end
    else
      if @user.amount <= 50
        percent_asso = ((50-30.0)*((@user.amount-30)/(50-30)))+30
      elsif (@user.amount <= 100)
        percent_asso = ((70-50.0)*((@user.amount-50)/(100-50)))+50
      elsif (@user.amount <= 150)
        percent_asso = ((75-70.0)*((@user.amount-100)/(150-100)))+70
      elsif (@user.amount <= 200)
        percent_asso = ((77.5-75)*((@user.amount-150)/(200-150)))+75
      elsif (@user.amount <= 250)
        percent_asso = ((80-77.5)*((@user.amount-200)/(250-200)))+77.5
      else
        percent_asso = ((85-80.0)*((@user.amount-250)/(500-250)))+80
      end
    end

    debited_funds = @user.amount*100
    credited_funds =  debited_funds*percent_asso/100
    fees = debited_funds - credited_funds

    payin_info = {
      AuthorId: @user.mangopay_id,
      DebitedFunds: { Currency: 'EUR', Amount: debited_funds },
      CreditedFunds: { Currency: 'EUR', Amount: credited_funds },
      Fees: { Currency: 'EUR', Amount: fees },
      CreditedWalletId: wallet_id,
      CardId: @user.card_id,
      SecureMode:"DEFAULT",
      SecureModeReturnURL:"https://www.cforgood.com",
      StatementDescriptor: "CFORGOOD"
    }

    mangopay_payin_card_direct(payin_info)

  end


  def create_mangopay_legal_user
    legal_user_info = {
      Name: @user.name,
      Email: @user.email,
      LegalPersonType: "BUSINESS",
      LegalRepresentativeFirstName: @user.representative_first_name,
      LegalRepresentativeLastName: @user.representative_last_name,
      LegalRepresentativeBirthday: 0,
      LegalRepresentativeNationality: 'FR',
      LegalRepresentativeCountryOfResidence: 'FR'
    }

    mangopay_legal_user_create(legal_user_info)
  end

  def create_mangopay_wallet
    wallet_info = {
      Owners: [@user.mangopay_id],
      Description: "Portefeuille de #{@user.name}",
      Currency: 'EUR'
    }

    mangopay_wallet_create(wallet_info)
  end

  def create_mangopay_iban_bankaccount
    bankwire_info = {
      Type: "IBAN",
      OwnerName: @user.name,
      OwnerAddress: {
        AddressLine1: @user.street,
        City: @user.city,
        PostalCode: @user.zipcode,
        Country: "FR"
      },
      IBAN: "FR3020041010124530725S03383",
      BIC: "CRLYFRPP"
    }

    mangopay_iban_bankaccount_create(@user.mangopay_id, bankwire_info)

    # @mangopay_user = MangopayServices.new(User.first).create_mangopay_iban_bankaccount
  end

def create_mangopay_mandate
    mandate_info = {
      BankAccountId: "16618384",
      Culture: "FR",
      ReturnURL: "https://www.cforgood.com"
    }

    mangopay_mandate_create(mandate_info)

    # result = MangopayServices.new(User.first).create_mangopay_mandate
  end


  def create_mangopay_bankwire_payin(wallet_id)

    if @user.amount <= 5
      percent_asso = ((50-30)*((@user.amount-1)/(5.0-1.0)))+30;
    elsif @user.amount <= 10
      percent_asso = ((70-50)*((@user.amount-5)/(10.0-5.0)))+50;
    elsif @user.amount <= 15
      percent_asso = ((75-70)*((@user.amount-10)/(15.0-10.0)))+70;
    elsif @user.amount <= 20
      percent_asso = ((77.5-75)*((@user.amount-15)/(20.0-15.0)))+75;
    elsif @user.amount <= 25
      percent_asso = ((80-77.5)*((@user.amount-20)/(25.0-20.0)))+77.5;
    elsif @user.amount <= 50
      percent_asso = (((85-80)*((@user.amount-25)/(50.0-25.0)))+80);
    end

    debited_funds = @user.amount*100
    credited_funds =  debited_funds*percent_asso/100
    fees = debited_funds - credited_funds

    payin_info = {
      AuthorId: @user.mangopay_id,
      DeclaredDebitedFunds: { Currency: 'EUR', Amount: debited_funds },
      CreditedFunds: { Currency: 'EUR', Amount: credited_funds },
      DeclaredFees: { Currency: 'EUR', Amount: fees },
      CreditedWalletId: wallet_id,
    }

    mangopay_payin_bankwire_direct(payin_info)

  end



  private

  def mangopay_natural_user_create(user_info)
    MangoPay::NaturalUser.create(user_info)
  end

  def mangopay_card_registration_create(card_registration_info)
    MangoPay::CardRegistration.create(card_registration_info)
  end

  def mangopay_payin_card_direct(payin_info)
    begin
      MangoPay::PayIn::Card::Direct.create(payin_info)
    rescue MangoPay::ResponseError => e
      return e.message
    end
  end

  def mangopay_legal_user_create(legal_user_info)
    MangoPay::LegalUser.create(legal_user_info)
  end

  def mangopay_wallet_create(wallet_info)
    MangoPay::Wallet.create(wallet_info)
  end

  def mangopay_payin_card_direct(payin_info)
    begin
      MangoPay::PayIn::Card::Direct.create(payin_info)
    rescue MangoPay::ResponseError => e
      return e.message
    end
  end

  def mangopay_iban_bankaccount_create(user_mangopay_id, bankwire_info)
    MangoPay::BankAccount.create(user_mangopay_id, bankwire_info)
  end

  def mangopay_mandate_create(mandate_info)
    begin
      MangoPay::Mandate.create(mandate_info)
    rescue MangoPay::ResponseError => e
      return e.message
    end
  end

  def mangopay_payin_bankwire_direct(payin_info)
    begin
      MangoPay::PayIn::BankWire::Direct.create(payin_info)
    rescue MangoPay::ResponseError => e
      return e.message
    end
  end

end

