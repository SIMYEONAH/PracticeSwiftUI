import SwiftUI

struct GridTestView: View {
    var body: some View {
        TabView {
            StoreGridView()
                .tabItem {
                    Label("상점", systemImage: "cart")
                }
            Text("홈")
                .tabItem {
                    Label("홈", systemImage: "house")
                }
            Text("캐릭터")
                .tabItem {
                    Label("캐릭터", systemImage: "person")
                }
            Text("마이페이지")
                .tabItem {
                    Label("마이페이지", systemImage: "person.crop.circle")
                }
        }
    }
}

struct StoreGridView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(products) { product in
                        ProductItemWrapper(product: product)
                    }
                }
                .padding()
            }
            .navigationTitle("상점")
        }
    }
}

struct ProductItemView: View {
    let imageName: String
    let name: String
    let price: Int
    @Binding var isPressed: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(imageName)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 18)

            Text(name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.black)

            Text("\(price) 코인")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(8)
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
    }
}

struct ProductItemWrapper: View {
    let product: Product
    @State private var isPressed = false

    var body: some View {
        NavigationLink(destination: ProductDetailView(product: product)) {
            ProductItemView(
                imageName: product.imageName,
                name: product.name,
                price: product.price,
                isPressed: $isPressed
            )
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        isPressed = false
                    }
                }
        )
    }
}



struct ProductDetailView: View {
    let product: Product
    @State private var rotate = false

    var body: some View {
        VStack(spacing: 20) {
            Image(product.imageName)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(rotate ? 5 : -5))
                .animation(
                    .easeInOut(duration: 0.4).repeatForever(autoreverses: true),
                    value: rotate
                )
                .onAppear {
                    rotate = true
                }

            Text(product.name)
                .font(.title)
                .fontWeight(.bold)

            Text("가격: \(product.price)")
                .font(.headline)

            Spacer()
        }
        .padding()
        .navigationTitle("상세보기")
    }
}


struct Product: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let price: Int
}

let products = [
    Product(imageName: "gamepad-icon", name: "게임하기", price: 199),
    Product(imageName: "gift-icon", name: "랜덤박스선물", price: 159),
    Product(imageName: "medicine-bottles-icon-1", name: "강력약물 치료", price: 89),
    Product(imageName: "medicine-bottles-icon", name: "약물 치료", price: 189),
    Product(imageName: "salad-icon-1", name: "샐러드", price: 229),
    Product(imageName: "stethoscope-icon", name: "진료받기", price: 209),
    Product(imageName: "volleyball-ball-icon", name: "배구놀이", price: 89),
    Product(imageName: "musical-note-icon", name: "음악듣기", price: 189),
]

#Preview {
    GridTestView()
}
