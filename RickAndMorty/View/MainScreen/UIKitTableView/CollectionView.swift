//
//  CollectionView.swift
//  RickAndMorty
//
//  Created by Domiik on 20.08.2023.
//

import SwiftUI


struct CollectionView: UIViewRepresentable {
    
    @Binding var items: [Result]?
    @ObservedObject var viewModel = MainScreenViewModel()
    @Binding var selectedItem: Result?
    
    @Binding var isDetailViewPresentedB: Bool
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
               activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
               activityIndicator.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor) // Вы можете настроить отступ снизу по вашему усмотрению
           ])
     
        context.coordinator.activityIndicator = activityIndicator
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        // Обновите отображение индикатора загрузки
        if context.coordinator.isLoadingNextPage {
            if let activityIndicator = uiView.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
                activityIndicator.startAnimating()
            }
        } else {
            if let activityIndicator = uiView.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
            }
        }
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        let parent: CollectionView
        var isLoadingNextPage = false
        var activityIndicator: UIActivityIndicatorView?
        
        init(_ collectionView: CollectionView) {
            self.parent = collectionView

        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let screenHeight = scrollView.frame.size.height
            
            // Проверка условий для подгрузки следующей страницы
            if offsetY > contentHeight - screenHeight && !isLoadingNextPage {
                loadNextPageIfNeeded()
            }
        }
        
        // Загрузка следующей страницы, если необходимо
        func loadNextPageIfNeeded() {
            isLoadingNextPage = true
            guard let nextPage = parent.viewModel.heroes?.info.next else {
                return
            }
            
            parent.viewModel.loadNextPage(nextPage: nextPage) { success in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [self] in
                    if success {
                        parent.items = parent.viewModel.resultHero
                        isLoadingNextPage = false
                    } else { }
                    self.activityIndicator?.stopAnimating()
                    isLoadingNextPage = false
                }
            }
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return parent.items?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            
            if let item = parent.items?[indexPath.item] {
                if let imageUrl = URL(string: item.image) {
                    cell.configure(with: imageUrl, text: item.name)
                } else {
                    cell.configure(with: nil, text: item.name)
                }
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 156, height: 202)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let selectedItem = parent.items?[indexPath.item] {
                parent.selectedItem = selectedItem
                parent.isDetailViewPresentedB = true
            }
        }
        
    }
}

class ImageCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    // Создаем UILabel для отображения текста
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    func configure(with imageUrl: URL?, text: String?) {
        let placeholderImage = UIImage(named: "placeholder.png")
        
        if let imageUrl = imageUrl {
            imageView.kf.setImage(
                with: imageUrl,
                placeholder: placeholderImage,
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage,
                    .loadDiskFileSynchronously,
                ]
            )
        } else {
            imageView.image = nil
        }
        
        textLabel.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = UIColor(asset: .cellColor)
        layer.cornerRadius = 20
        clipsToBounds = true
        
        // Добавляем UIImageView на ячейку
        contentView.addSubview(imageView)
        
        // Добавляем UILabel на ячейку
        contentView.addSubview(textLabel)
        
        // Задаем констрейнты для UIImageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        // Задаем констрейнты для UILabel
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
