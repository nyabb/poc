
User.create(firstname: 'Pascal',  lastname: 'Wilbrink',       date_of_birth: '05-11-1991', password: 'test', password_confirmation: 'test', phone: '0572-358962', mobile_phone: '31657595773',  adres:'Majoraan 26',        zipcode:'8101 DP',  place: 'Raalte', email: 'pascal_wilbrink676@hotmail.com',  remember_token: 'c1ed7', latitude:'51.987743', longitude:'5.950249', radius:'500')
User.create(firstname: 'Willem',  lastname: 'van Lent',       date_of_birth: '26-04-1993', password: 'test', password_confirmation: 'test', phone: '1234-567890', mobile_phone: '31627467554',  adres:'Ruitenberglaan 26',  zipcode:'8102 AA',  place: 'Arnhem', email: 'willemvanlent@live.nl',  remember_token: 'c1ed7', latitude:'51.986012', longitude:'5.957309', radius: '2000')
User.create(firstname: 'Madelon', lastname: 'Oude Vrielink',  date_of_birth: '26-04-1990', password: 'test', password_confirmation: 'test', phone: '1234-567890', mobile_phone: '31624334415',  adres:'Ruitenberglaan 26',  zipcode:'8102 AA',  place: 'Arnhem', email: 'madelon@pascal.com', remember_token: 'c1ed7', latitude:'51.973430', longitude:'5.937053', radius:'1500')
User.create(firstname: 'Natnael', lastname: 'Yonathan Abbai', date_of_birth: '26-04-1990', password: 'test', password_confirmation: 'test', phone: '1234-567890', mobile_phone: '31681771770',  adres:'Ruitenberglaan 26',  zipcode:'8102 AA',  place: 'Arnhem', email: 'natnaelyntn@gmail.com', remember_token: 'c1ed7', latitude:'51.970046', longitude:'5.910102', radius:'5000')

Country.create(name:'Nederlands',short_name:'nl');
Country.create(name:'Engels',short_name:'en');
Country.create(name:'Turks',short_name:'tr');
Country.create(name:'Marokkaans',short_name:'ma');