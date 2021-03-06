# TableViewExtension

When we are working with UITableView with code or Nibs we always have to write lots of code for to tableview do its job. This extension helps you write more swifty way to do so.

## Usage

You can register a UITableViewCell, HeaderFooterView as simple as like;
```swift
tableView.reuse(CustomTableViewCell.self, fromNib: true) // fromNib is a optional. Default value is false.
```
You can use this method to dequeue your cell or header view;
```swift
tableView.dequeue(indexPath, fromNib: true)
```

Here is full the implementation

```swift
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView
            .reuse(InfoCell.self) // Without nib file
            .reuse(CustomTableViewCell.self, fromNib: true) // With nib file
            .registerHeaderFooter(HeaderView.self, fromNib: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let infoCell: InfoCell = tableView.dequeue(indexPath)
            return infoCell
        } else {
            let secondCell: SecondTableViewCell = tableView.dequeue(indexPath, fromNib: true)
            return secondCell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView: HeaderView? = tableView.dequeueHeaderFooter(fromNib: true)
        
        return sectionHeaderView
    }
}

```
