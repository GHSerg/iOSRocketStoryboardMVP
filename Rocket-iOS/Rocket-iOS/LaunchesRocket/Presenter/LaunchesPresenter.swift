import Foundation

protocol LaunchesViewControllerProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol LaunchesPresenterProtocol: AnyObject{
    init (view: LaunchesViewControllerProtocol, networkService: NetworkServiceProtocol)
    
    var launchesRocket: [LaunchesJsonModel]? { get set }
    func getLaunchesRocket()
    func convertDate(dateLaunch: String) -> String  
}

class LaunchesPresenter: LaunchesPresenterProtocol {
    
    weak var view: LaunchesViewControllerProtocol?
    let networkService: NetworkServiceProtocol?
    var launchesRocket: [LaunchesJsonModel]?
    var idRocket = "5e9d0d95eda69955f709d1eb"
    
    required init(view: LaunchesViewControllerProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getLaunchesRocket()
    }
    
    func getLaunchesRocket() {
        networkService?.getLaunchesRocket { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let launchesRocket):
                    self.launchesRocket = launchesRocket
                    self.filterlaunchesRocket ()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
                
            }
        }
    }
    
    func convertDate (dateLaunch: String) -> String {
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = formatterDate.date(from: dateLaunch) else { return "none" }
        
        formatterDate.dateFormat = "dd MMMM, yyyy"
        formatterDate.string(from: date)
        return (formatterDate.string(from: date))
    }
    
    
    func filterlaunchesRocket () {
        launchesRocket = launchesRocket?
            .filter{ $0.rocket == idRocket }
            .reversed()
        self.view?.succes()
    }
    
}

//    func requestDataRocket(urlString: String, completion: @escaping ([rocketData]?, Error?) -> Void) {
//            guard let url = URL(string: urlString) else {
//                return
//            }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                DispatchQueue.main.async {
//                    guard error == nil, let data = data else { return }
//
//                    do {
//                        let json = try JSONDecoder().decode([rocketData].self, from: data)
//                        completion (json, nil)
//                        // print(json)
//                    } catch {
//                        //   print(error)
//                        completion (nil, error)
//                    }
//                }
//
//            }.resume()
//        }

//class SecondPresent {
//
//    //var rocketData = SecondJsonModel()
//
//    var nameRocket: String?
//    var rocketLaunches: [rocketData]? {
//        didSet {
//           // print (self.rocketLaunches ?? default value)
//            rocketLaunches = rocketLaunches?
//                .filter{ $0.rocket == idRocket }
//                .reversed()
//           // convertDate()
//          //  setData()
//          //  self.rocketTableView.reloadData()
//
//        }
//    }
//
//    var idRocket: String?
//
//   // self.rocketTableView.register(UINib(nibName: "SecondScreenTableViewCell", bundle: nil),
//    forCellReuseIdentifier: "SecondScreenTableViewCell")
//
//    requestSecondView(urlString: "https://api.spacexdata.com/v4/launches") { json, error in
//        self.rocketLaunches = json
//        //print (self.rocketLaunches)
//    }
//
//    self.rocketNameTitleLabel.text = self.nameRocket
//
//
//
//
//
//    extension SecondViewController {
//
//        func convertDate(dateLaunch: String) -> String {
//
//                            let formatterDate = DateFormatter()
//                            let timestamp = dateLaunch
//                            formatterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//                            let date = formatterDate.date(from: timestamp)
//                            formatterDate.dateFormat = "dd MMMM, yyyy"
//                            print (formatterDate.string(from: date!))
//                            //firstFlightLabel.text = formatterDate.string(from: date!)
//                            return (formatterDate.string(from: date!))
//        }
//    }
//
//    func requestDataRocket(urlString: String, completion: @escaping ([rocketData]?, Error?) -> Void) {
//        guard let url = URL(string: urlString) else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                guard error == nil, let data = data else { return }
//
//                do {
//                    let json = try JSONDecoder().decode([rocketData].self, from: data)
//                    completion (json, nil)
//                    // print(json)
//                } catch {
//                    //   print(error)
//                    completion (nil, error)
//                }
//            }
//
//        }.resume()
//    }
//
//}
//
////    var nameRocket: String?
////    var rocketLaunches: [SecondViewJsonRocket]? {
////        didSet {
////           // print (self.rocketLaunches ?? <#default value#>)
////            rocketLaunches = rocketLaunches?
////                .filter{ $0.rocket == idRocket }
////                .reversed()
////           // convertDate()
////          //  setData()
////            self.rocketTableView.reloadData()
////
////        }
////    }
////
////    var idRocket: String?
//
////        self.rocketTableView.register(UINib(nibName: "SecondScreenTableViewCell", bundle: nil),
////        forCellReuseIdentifier: "SecondScreenTableViewCell")
////
////        requestSecondView(urlString: "https://api.spacexdata.com/v4/launches") { json, error in
////            self.rocketLaunches = json
////            //print (self.rocketLaunches)
////        }
////
////        self.rocketNameTitleLabel.text = self.nameRocket
//
////
////    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
////            return 16
////    }
//
//
////extension SecondViewController {
////
////    func convertDate(dateLaunch: String) -> String {
////
////                        let formatterDate = DateFormatter()
////                        let timestamp = dateLaunch
////                        formatterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
////                        let date = formatterDate.date(from: timestamp)
////                        formatterDate.dateFormat = "dd MMMM, yyyy"
////                        print (formatterDate.string(from: date!))
////                        //firstFlightLabel.text = formatterDate.string(from: date!)
////                        return (formatterDate.string(from: date!))
////    }
////}