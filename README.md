# TableViewExtension

##Usage
```

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView
            .registerReusable(CustomTableViewCell.self, fromNib: true)
            .registerReusable(SecondTableViewCell.self, fromNib: true)
            .registerReusableHeaderFooterClass(HeaderView.self, fromNib: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell: CustomTableViewCell = tableView.dequeueReusable(indexPath, fromNib: true)
            return cell
        } else {
            let cell: SecondTableViewCell = tableView.dequeueReusable(indexPath, fromNib: true)
            return cell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView: HeaderView? = tableView.dequeueReusableHeaderFooterView(fromNib: true)
        
        return sectionHeaderView
    }
}

```
