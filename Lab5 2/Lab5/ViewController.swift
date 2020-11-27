
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = authors[indexPath.row] ?? ""
        
        return cell
    }
    
    
    let urlSt = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=69698df82a724ba9b3979013183abb34"
    var authors = [String]()
    var titles = [String]()
    
    @IBOutlet weak var table: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        parse()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func parse(){
        if let url = URL(string: urlSt){
            let session = URLSession.shared
            
            session.dataTask(with: url) { (data, resp, error) in
                if let data = data{
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                let articles = json?["articles"] as! [[String: Any]]
                for news in articles{
                    if let author = news["author"] as? String{
                        self.authors.append(author)
                    }
                    if let titleN = news["title"] as? String{
                        self.titles.append(titleN)
                    }
                    
                }
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                }
            }.resume()
        
        }
    }


}

