import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(self)
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
extension UICollectionViewCell: Reusable { }

extension UITableView {
    
    // Cells
    func registerReusable(cellClass: Reusable.Type, fromNib: Bool = false) -> UITableView {
        if fromNib {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
            self.registerNib(nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            self.registerClass(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
        }
        
        return self
    }
    
    func dequeueReusable<T: UITableViewCell where T: Reusable>(indexPath: NSIndexPath, fromNib: Bool = false) -> T {
        return self.dequeueReusableCellWithIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as! T
    }
    
    // HeaderFooterViews
    func registerReusableHeaderFooterClass(headerFooterViewClass: Reusable.Type, fromNib: Bool = false) -> UITableView {
        if fromNib {
            let nib = UINib(nibName: headerFooterViewClass.reuseIdentifier, bundle: nil)
            self.registerNib(nib, forHeaderFooterViewReuseIdentifier: headerFooterViewClass.reuseIdentifier)
        } else {
            self.registerClass(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: headerFooterViewClass.reuseIdentifier)
        }
        
        return self
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView where T: Reusable>(fromNib fromNib: Bool = false) -> T? {
        return self.dequeueReusableHeaderFooterViewWithIdentifier(T.reuseIdentifier) as? T
    }
}

extension UICollectionView {
    func registerReusable(cellClass: Reusable.Type, fromNib: Bool = false) -> UICollectionView {
        if fromNib {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
            self.registerNib(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            self.registerClass(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }
        
        return self
    }
    
    func dequeueReusable<T: UICollectionViewCell where T: Reusable>(indexPath: NSIndexPath, fromNib: Bool = false) -> T {
        self.registerReusable(T.self, fromNib: fromNib)
        return self.dequeueReusableCellWithReuseIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as! T
    }
}