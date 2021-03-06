import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
extension UICollectionViewCell: Reusable { }

extension UITableView {
    
    // Cells
    func reuse(cellClass: Reusable.Type, fromNib: Bool = false) -> UITableView {
        if fromNib {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
            self.register(nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            self.register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
        }
        
        return self
    }
    
    func dequeue<T: UITableViewCell>(indexPath: IndexPath, fromNib: Bool = false) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    // HeaderFooterViews
    func registerHeaderFooter(headerFooterViewClass: Reusable.Type, fromNib: Bool = false) -> UITableView {
        if fromNib {
            let nib = UINib(nibName: headerFooterViewClass.reuseIdentifier, bundle: nil)
            self.register(nib, forHeaderFooterViewReuseIdentifier: headerFooterViewClass.reuseIdentifier)
        } else {
            self.register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: headerFooterViewClass.reuseIdentifier)
        }
        
        return self
    }
    
    func dequeHeaderFooter<T: UITableViewHeaderFooterView>(fromNib: Bool = false) -> T? where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T
    }
}

extension UICollectionView {
    func reuse(cellClass: Reusable.Type, fromNib: Bool = false) -> UICollectionView {
        if fromNib {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            self.register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }
        
        return self
    }
    
    func dequeue<T: UICollectionViewCell>(indexPath: IndexPath, fromNib: Bool = false) -> T where T: Reusable {
        self.(cellClass: T.self, fromNib: fromNib)
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath ) as! T
    }
}
