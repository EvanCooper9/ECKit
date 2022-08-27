import UIKit

public extension UICollectionView {
    
    enum ElementKind {
        case header
        case footer
        
        var value: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
    
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerNib<T: UICollectionViewCell>(cellType: T.Type) {
        let identifier = String(describing: T.self)
        register(
            UINib(nibName: identifier, bundle: .main),
            forCellWithReuseIdentifier: identifier
        )
    }
    
    func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, elementKind: ElementKind = .header) {
        register(
            T.self,
            forSupplementaryViewOfKind: elementKind.value,
            withReuseIdentifier: String(describing: T.self)
        )
    }
    
    func registerNib<T: UICollectionReusableView>(supplementaryViewType: T.Type, elementKind: ElementKind = .header) {
        let identifier = String(describing: T.self)
        register(
            UINib(nibName: identifier, bundle: .main),
            forSupplementaryViewOfKind: elementKind.value,
            withReuseIdentifier: identifier
        )
    }
    
    func dequeue<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func dequeue<T: UICollectionReusableView>(reusableViewType: T.Type, elementKind: ElementKind = .header, for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(
            ofKind: elementKind.value,
            withReuseIdentifier: String(describing: T.self),
            for: indexPath
        ) as! T
    }
}
