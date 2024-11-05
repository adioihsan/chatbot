import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout';
import { Head,Link } from '@inertiajs/react';
import { TbMessageChatbotFilled } from "react-icons/tb";

export default function Dashboard() {
    return (
        <AuthenticatedLayout
            header={
                <h2 className="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
                    Dashboard
                </h2>
            }
        >
            <Head title="Dashboard" />

            <div className="py-12">
                <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
                        <Link className='p-3 bg-white shadow-lg w-full rounded-lg flex items-center gap-2'  href='/chat'>
                            <TbMessageChatbotFilled />
                            <span>ChatBot</span>
                        </Link>
                </div>
            
            </div>
        </AuthenticatedLayout>
    );
}
